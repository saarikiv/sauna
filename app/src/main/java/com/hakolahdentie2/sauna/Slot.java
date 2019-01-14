package com.hakolahdentie2.sauna;
import com.google.firebase.database.IgnoreExtraProperties;

@IgnoreExtraProperties
public class Slot {
    public String key;
    public boolean blocked;
    public int day;
    public int end;
    public int start;
    public String reserver;

    public Slot() {
        // Default constructor required for calls to DataSnapshot.getValue(User.class)
    }

    public Slot(boolean blocked,
                int day,
                int end,
                int start,
                String reserver) {
        this.blocked = blocked;
        this.day = day;
        this.end = end;
        this.start = start;
        this.reserver = reserver;
    }

    @Override
    public String toString() {
        return new StringBuilder()
                .append("KEY:").append(key)
                .append(" Blocked:").append(blocked)
                .append(" Day:").append(day)
                .append(" End:").append(end)
                .append(" Start: ").append(start)
                .append(" Reserver:").append(reserver)
                .toString();
    }
}

