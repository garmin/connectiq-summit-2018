using Toybox.ActivityMonitor;
using Toybox.Graphics;
using Toybox.WatchUi;

class StepsGoalView extends WatchUi.View {

    hidden var mTarget;
    hidden var mPoints;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        var activityInfo = ActivityMonitor.getInfo();
        mTarget = activityInfo.stepGoal.format("%d");

        var cx = dc.getWidth() / 2;
        var cy = dc.getHeight() / 2;

        // transform mPoints once at layout time
        mPoints = [
            [-80, -80], [-33, -80], [   0, -113], [ 33, -80],
            [ 80, -80], [ 80, -33], [ 113,    0], [ 80,  33],
            [ 80,  80], [ 33,  80], [   0,  113], [-33,  80],
            [-80,  80], [-80,  33], [-113,    0], [-80, -33]
        ];
        for (var i = 0; i < mPoints.size(); ++i) {
            mPoints[i][0] += cx;
            mPoints[i][1] += cy;
        }
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        var cx = dc.getWidth() / 2;
        var cy = dc.getHeight() / 2;

        dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
        dc.fillPolygon(mPoints);

        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(cx, cy, 80);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(cx, cy - dc.getFontHeight(Graphics.FONT_NUMBER_HOT) / 2, Graphics.FONT_NUMBER_HOT,
            mTarget, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(cx, cy + dc.getFontHeight(Graphics.FONT_NUMBER_HOT) / 2, Graphics.FONT_LARGE,
            "Steps", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}
