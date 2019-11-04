import React from 'react';
import { requireNativeComponent } from 'react-native';
import PropTypes from "prop-types";

const TimePickerView = requireNativeComponent("TimePickerIOS")

class TimePickerIOS extends React.Component {

    onChange = (event) => {
        const { onChange } = this.props;
        if (!onChange || typeof onChange !== "function") {
            return
        }
        const {
            hour = 0,
            minute = 0,
            second = 0,
            millisecond = 0,
        } = event.nativeEvent;

        if (!this.props.isDateShow) {
            onChange({ hour, minute, second, millisecond });
            return;
        }

        const {
            day,
            month,
            year,
        } = event.nativeEvent;

        onChange({ day, month, year, hour, minute, second, millisecond });
    }

    render() {
        const {
            isDateShow = false,
            day = 1,
            month = 1,
            year = 1970,
            hour = 0,
            minute = 0,
            second = 0,
            millisecond = 0,
        } = this.props;

        return (
           <TimePickerView
               style={{ height: 200, width: isDateShow ? 400 : 300 }}
               isDateShow={isDateShow}
               day={day}
               month={month}
               year={year}
               hour={hour}
               minute={minute}
               second={second}
               millisecond={millisecond}
               onChange={this.onChange}
           />
        );
    }
}

TimePickerIOS.propTypes = {
    isDateShow: PropTypes.bool,
    day: PropTypes.number,
    month: PropTypes.number,
    year: PropTypes.number,
    hour: PropTypes.number,
    minute: PropTypes.number,
    second: PropTypes.number,
    millisecond: PropTypes.number,
    onChange: PropTypes.func,
}

export { TimePickerIOS }