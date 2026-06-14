import { useState } from "react";
import FullCalendar from "@fullcalendar/react";
import type {
    DateSelectArg,
    EventClickArg,
    // EventApi,
    // EventInput,
} from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import interactionPlugin from "@fullcalendar/interaction"; // needed for select, drag & drop
import { Box, Dialog, DialogActions, DialogContent, DialogTitle, Button, TextField } from "@mui/material";

interface EventType {
  id: string;
  title: string;
  start: string;
  end?: string;
}

export default function AppointmentPage() {
  const [events, setEvents] = useState<EventType[]>([]);
  const [open, setOpen] = useState(false);
  const [newEvent, setNewEvent] = useState<{ title: string; start: string }>({
    title: "",
    start: "",
  });

  // ✅ When selecting a date range/day
  const handleDateSelect = (selectInfo: DateSelectArg) => {
    setNewEvent({ title: "", start: selectInfo.startStr });
    setOpen(true);
  };

  // ✅ Save appointment
  const handleSave = () => {
    setEvents((prev) => [
      ...prev,
      {
        id: String(prev.length + 1),
        title: newEvent.title || "Untitled",
        start: newEvent.start,
      },
    ]);
    setOpen(false);
  };

  // ✅ Delete appointment
  const handleEventClick = (clickInfo: EventClickArg) => {
    if (window.confirm(`Delete event '${clickInfo.event.title}'?`)) {
      setEvents((prev) => prev.filter((e) => e.id !== clickInfo.event.id));
    }
  };

  return (
    <>
        <Box sx={{ p: 2 }}>
            <FullCalendar
                plugins={[dayGridPlugin, timeGridPlugin, interactionPlugin]}
                initialView="dayGridMonth"
                selectable={true}
                editable={true}
                selectMirror={true}
                dayMaxEvents={true}
                select={handleDateSelect}
                events={events}
                eventClick={handleEventClick}
                height="80vh"
            />

            {/* Modal for new appointment */}
            <Dialog open={open} onClose={() => setOpen(false)}>
                <DialogTitle>New Appointment</DialogTitle>
                <DialogContent>
                <TextField
                    fullWidth
                    label="Title"
                    value={newEvent.title}
                    onChange={(e) =>
                    setNewEvent({ ...newEvent, title: e.target.value })
                    }
                    margin="dense"
                />
                </DialogContent>
                <DialogActions>
                <Button onClick={() => setOpen(false)}>Cancel</Button>
                <Button variant="contained" onClick={handleSave}>
                    Save
                </Button>
                </DialogActions>
            </Dialog>
        </Box>
    </>
  );
}
