using Toybox.Graphics;
using Toybox.System;

class ColorController
{
    hidden var mColor;

    function initialize() {
        mColor = Graphics.COLOR_RED;
    }

    function getInitialView() {
        return [ new RedView(), new ColorBehaviorDelegate(self) ];
    }

    function switchView(aBehavior, anInputName, aTransition) {
        // determine the color of the next page based on what is legal for our
        // current state
        var aColor = null;
        if (mColor == Graphics.COLOR_RED) {
            aColor = fromRedView(aBehavior);
        }
        else if (mColor == Graphics.COLOR_GREEN) {
            aColor = fromGreenView(aBehavior);
        }
        else if (mColor == Graphics.COLOR_DK_RED) {
            aColor = fromDarkRedView(aBehavior);
        }
        else if (mColor == Graphics.COLOR_DK_GREEN) {
            aColor = fromDarkGreenView(aBehavior);
        }
        else {
            return false; // current state not known
        }

        if (aColor == null) {
            return false; // don't change states
        }

        // given a color, get a view instance of the correct type
        var aView = null;
        if (aColor == Graphics.COLOR_RED) {
            aView = new RedView();
        }
        else if (aColor == Graphics.COLOR_GREEN) {
            aView = new GreenView();
        }
        else if (aColor != null) {
            aView = new ColorView(aColor);
        }
        else {
            return false; // next state unknown
        }

        // log the behavior and input that led to the transition we're
        // about to make
        System.println(Lang.format("$1$ $2$ $3$", [
            anInputName,
            BEHAVIOR_NAMES[aBehavior],
            TRANSITION_NAMES[aTransition]
        ]));

        WatchUi.switchToView(aView, new ColorBehaviorDelegate(self), aTransition);

        // cache the current view state
        mColor = aColor;

        return true;
    }

    hidden function fromRedView(aBehavior) {
        if (aBehavior == BEHAVIOR_NEXT_PAGE) {
            return Graphics.COLOR_GREEN;
        }
        else if (aBehavior == BEHAVIOR_ON_SELECT) {
            return Graphics.COLOR_DK_RED;
        }

        return null;
    }

    hidden function fromGreenView(aBehavior) {
        if (aBehavior == BEHAVIOR_PREVIOUS_PAGE || aBehavior == BEHAVIOR_ON_BACK) {
            return Graphics.COLOR_RED;
        }
        else if (aBehavior == BEHAVIOR_ON_SELECT) {
            return Graphics.COLOR_DK_GREEN;
        }

        return null;
    }

    hidden function fromDarkRedView(aBehavior) {
        if (aBehavior == BEHAVIOR_ON_BACK) {
            return Graphics.COLOR_RED;
        }

        return null;
    }

    hidden function fromDarkGreenView(aBehavior) {
        if (aBehavior == BEHAVIOR_ON_BACK) {
            return Graphics.COLOR_GREEN;
        }

        return null;
    }

}
