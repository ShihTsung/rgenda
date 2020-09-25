import moment from "moment";

export function getShiftTimeStr(shift) {
  let start, end;
  if (shift.start) {
    start = shift.start;
  } else if (shift.start_time) {
    start = shift.start_time;
  } else {
    throw "No valid start time property.";
  }

  if (shift.end) {
    end = shift.end;
  } else if (shift.end_time) {
    end = shift.end_time;
  } else {
    throw "No valid end time property.";
  }
  return (
    moment(start, ["HH:mm:ss", "HH:mm"]).format("HH") +
    "-" +
    moment(end, ["HH:mm:ss", "HH:mm"]).format("HH")
  );
}

export function getArrow(application) {
  return application.user_apply_id !== null
    ? "fas fa-exchange-alt"
    : "fas fa-long-arrow-alt-right";
}
