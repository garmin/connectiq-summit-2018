using Toybox.WatchUi;

// A simple view that just displays as a single color
class ColorView extends WatchUi.View {

    hidden var mColor;

    function initialize(aColor) {
        View.initialize();
        mColor = aColor;
    }

    function onUpdate(dc) {
        dc.setColor(mColor, mColor);
        dc.clear();
    }
}
