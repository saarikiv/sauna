package com.hakolahdentie2.sauna;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.MenuItem;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.Query;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    private FirebaseAuth mAuth;
    private FirebaseUser mUser = null;
    private List<Slot> mSlots = new ArrayList<Slot>();

    public final class RC {
        public static final int RC_LOGIN = 0;
    }

    private BottomNavigationView.OnNavigationItemSelectedListener mOnNavigationItemSelectedListener
            = new BottomNavigationView.OnNavigationItemSelectedListener() {

        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem item) {
            switch (item.getItemId()) {
                case R.id.navigation_home:

                    return true;
                case R.id.navigation_dashboard:

                    return true;
                case R.id.navigation_notifications:

                    return true;
            }
            return false;
        }
    };

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data){
        Log.d("MainActivity", "onActivityResult");
        switch(requestCode){
            case RC.RC_LOGIN:
                mUser = mAuth.getCurrentUser();
                initializeData();
            default:
                Log.w("onActivityResult","Unknown activity result code received: " + requestCode);
        }
    }

    protected  void startUserListener(){
        FirebaseDatabase mDatabase = FirebaseDatabase.getInstance();

        DatabaseReference myUserRef = mDatabase.getReference(new StringBuilder().append("/users/").append(mUser.getUid()).toString());
        // Read from the database
        ValueEventListener valueEventListener = myUserRef.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                // This method is called once with the initial value and again
                // whenever data at this location is updated.
                User value = dataSnapshot.getValue(User.class);
                Log.d("UpdateData", "Value is: " + value.toString());
            }

            @Override
            public void onCancelled(DatabaseError error) {
                // Failed to read value
                Log.w("UpdateData", "Failed to read value.", error.toException());
            }
        });
    }


    protected void initializeData(){
        // Write a message to the database
        FirebaseDatabase mDatabase = FirebaseDatabase.getInstance();

        mDatabase.getReference().child("slots").addListenerForSingleValueEvent( new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                if(dataSnapshot.exists()){
                    for(DataSnapshot oneSlot : dataSnapshot.getChildren()){
                        Log.d("UpdateData", "Slot:" + oneSlot.getKey());
                        Slot s = oneSlot.getValue(Slot.class);
                        s.key = oneSlot.getKey();
                        Log.d("UpdateData", "Slot: " + s);
                        mSlots.add(s);
                    }
                }
                updateView();
            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }
        });
    }

    protected void updateView() {

        LinearLayout slotList = (LinearLayout) findViewById(R.id.SlotListLayout);

        int index = 0;
        for(Slot one : mSlots){
            TextView slot = new TextView(this);
            slot.setText(one.toString());
            slotList.addView(slot, index++);
            Log.d("UpdateData", "Slot-from-list:" + one);
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);

        mAuth = FirebaseAuth.getInstance();

        BottomNavigationView navigation = (BottomNavigationView) findViewById(R.id.navigation);
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener);


    }


    @Override
    public void onStart() {
        super.onStart();
        if ( mUser == null ){
            Intent intent = new Intent(this, LoginActivity.class);
            startActivityForResult(intent,RC.RC_LOGIN);
        }
    }

}
