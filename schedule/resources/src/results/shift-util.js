export function getShiftClass(shift) {
  if (shift) {
    switch (shift.shift_type) {
      case 0:
        return "dayShift";
      case 1:
        return "nightShift";
      case 2:
        return "graveyardShift";
      case 7:
        return "adminis";
      case 3:
        return "rest";
      case 4:
        return "onCall";
      case 5:
        switch (shift.name) {
          case "休息":
          case "例假":
          case "國定假日":
            return "rest";
          case "補休":
          case "特休":
            return "restR";
        }
        return "restR";
      case 6:
        if (shift.name === "事假") {
          return "restR";
        }
        return "restR";
    }
  }
  return "";
}

export function getShiftText(shift) {
  if (shift) {
    switch (shift.shift_type) {
      case 0:
      case 1:
      case 2:
      case 7:
        return shift.code;
      case 3:
        return "公";
      case 4:
        return shift.code === ""
          ? "On"
          : shift.code;
      case 5:
        switch (shift.name) {
          case "休息":
            return "休";
          case "例假":
            return "例";
          case "補休":
            return "補";
          case "特休":
            return "特";
          case "空班":
            return "空";
          case "婚假":
            return "婚";
          case "喪假":
            return "喪";
          case "產假":
            return "產";
          case "生理假":
            return "生";
          case "國定假日":
            return "國";
          default:
            return shift.name[0]
        }
      case 6:
        switch (shift.name) {
          case "無薪病假":
            return "病";
          case "事假":
            return "事";
          case "家庭照顧假":
            return "家";
        }
        break;
    }
  }
  return "-";
}
