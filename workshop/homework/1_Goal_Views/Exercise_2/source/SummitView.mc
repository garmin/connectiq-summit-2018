//
// Copyright 2018 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.ActivityMonitor;

// This implements the Sample Watchface
class SummitView extends WatchUi.WatchFace
{
    hidden var mFont;
    hidden var mLogo;
    hidden var mSleep = true;

    // Initialize variables for this view
    function initialize() {
        WatchFace.initialize();
        mFont = WatchUi.loadResource(Rez.Fonts.ShoCardCaps);
        mLogo = WatchUi.loadResource(Rez.Drawables.Logo);
    }

     // Called when the watchface exits sleep mode
    function onExitSleep() {
        mSleep = false;
        WatchUi.requestUpdate();
    }

    // Called when the watchface enters sleep mode
    function onEnterSleep() {
        mSleep = true;
        WatchUi.requestUpdate();
    }

    // Configure the layout of the watchface for this device
    function onLayout(dc) {
        WatchFace.onLayout(dc);
    }

    // Handle the update event
    function onUpdate(dc) {
        WatchFace.onUpdate(dc);

        //Clear the scren to a black background
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        drawLogo(dc);
        drawPrimitives(dc);
        drawTime(dc, Graphics.COLOR_WHITE);
        drawSteps(dc);
    }

    function drawTime(dc, color) {
        //Compute the center point of the screen
        var x = dc.getWidth() / 2;
        var y = dc.getHeight() / 2;

        //Construct the time string
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);

        //Set the time color
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);

        //Draw the time to the center of the screen
        dc.drawText(x, y, mFont, timeString, (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER) );

        if (!mSleep) {
            drawSeconds(dc, clockTime.sec);
        }
    }

    function drawSeconds(dc, seconds) {
        var x = dc.getWidth() / 2;
        var y = dc.getHeight() * 5 / 6;

        //Draw the seconds in the lower center of the screen
        dc.drawText(
            x,
            y,
            Graphics.FONT_NUMBER_MILD,
            seconds.format("%02d"),
            (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER)
        );
    }

    function drawLogo(dc) {
        //Compute the center point of the screen
        var x = dc.getWidth() / 2 - mLogo.getWidth() / 2;
        var y = dc.getHeight() / 2 - mLogo.getHeight() / 2;

        //Draw the time to the center of the screen
        dc.drawBitmap(x, y, mLogo);
    }

    function drawSteps(dc) {
        var x = dc.getWidth() / 2;
        var y = dc.getHeight() / 6;
        var steps = ActivityMonitor.getInfo().steps;

        //Draw the steps in the upper center of the screen
        if( steps != null ) {
            dc.drawText(
                x,
                y,
                Graphics.FONT_NUMBER_MILD,
                steps.format("%d"),
                (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER)
            );
        }
    }

    function drawPrimitives(dc) {
        var mx = dc.getWidth();
        var my = dc.getHeight();

        var cx = mx / 2;
        var cy = my / 2;

        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_ORANGE);
        dc.fillEllipse(mx - 10, cy, 10, 10);

        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_GREEN);
        //dc.setPenWidth(10);
        //dc.drawRectangle(25, 85, 30, 30);
        dc.drawRectangle(cx - 10, my - 20, 20, 20);

        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLUE);
        var points = [[0, cy - 10], [20, cy + 10], [0, cy + 10]];
        dc.fillPolygon(points);
    }

}
