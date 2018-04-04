using Toybox.Graphics;
using Toybox.WatchUi;

class GreenView extends ColorView {

    function initialize() {
        ColorView.initialize(Graphics.COLOR_GREEN);
    }

    function onLayout(dc) {
        ColorView.onLayout(dc);

        var aHistoryIterator = null;
        if (Toybox has :SensorHistory && Toybox.SensorHistory has :getElevationHistory) {
            aHistoryIterator = Toybox.SensorHistory.getElevationHistory({
                :period => 1
            });
        }

        if (aHistoryIterator != null) {
            var aHistoryValue = aHistoryIterator.next();

            if (aHistoryValue != null) {
                aHistoryValue = aHistoryValue.data;
            }

            if (aHistoryValue != null) {
                ColorView.setText("Elevation", aHistoryValue.format("%0.2f"));
            }
            else {
                ColorView.setText("Elevation", "No Data");
            }
        }
        else {
            ColorView.setText("Elevation", "Not Supported");
        }
    }
}
