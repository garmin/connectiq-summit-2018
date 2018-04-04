using Toybox.Graphics;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;

class RedView extends ColorView {

    function initialize() {
        ColorView.initialize(Graphics.COLOR_RED);
    }

    function onUpdate(dc) {
        var aTm = Gregorian.info(Time.now(), Time.FORMAT_SHORT);

        ColorView.setText("Date", Lang.format("$1$-$2$-$3$", [
            aTm.year,
            aTm.month.format("%02d"),
            aTm.day.format("%02d")
        ]));

        ColorView.onUpdate(dc);
    }
}
