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
  return start.substring(0, 2) + "-" + end.substring(0, 2);
}

export function getArrow(application) {
  return application.user_apply !== null
    ? "fas fa-exchange-alt"
    : "fas fa-long-arrow-alt-right";
}
