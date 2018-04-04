using Toybox.WatchUi;

// A simple view that just displays as a single color
class ColorView extends WatchUi.View {

    hidden var mColor;

    function initialize(aColor) {
        View.initialize();
        mColor = aColor;
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.ColorPageLayout(dc));
    }

    function onUpdate(dc) {
        dc.setColor(mColor, mColor);
        dc.clear();

        for (var i = 0; i < mLayout.size(); ++i) {
            mLayout[i].draw(dc);
        }
    }

    function setText(aTopString, aBottomString) {
        var aTextDrawable;

        aTextDrawable = findDrawableById("top");
        if (aTextDrawable != null) {
            aTextDrawable.setText(aTopString != null ? aTopString.toString() : "-");
        }

        aTextDrawable = findDrawableById("bot");
        if (aTextDrawable != null) {
            aTextDrawable.setText(aBottomString != null ? aBottomString.toString() : "-");
        }
    }
}
