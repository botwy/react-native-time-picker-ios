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

        onChange({ hour, minute, second, millisecond });
    }

    render() {
        const {
            hour = 0,
            minute = 0,
            second = 0,
            millisecond = 0,
        } = this.props;

        return (
           <TimePickerView
               style={{height: 200, width: 300}}
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
    hour: PropTypes.number,
    minute: PropTypes.number,
    second: PropTypes.number,
    millisecond: PropTypes.number,
    onChange: PropTypes.func,
}

export { TimePickerIOS }