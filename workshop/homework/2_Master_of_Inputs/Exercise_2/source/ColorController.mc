using Toybox.Graphics;
using Toybox.System;

class ColorController
{
    hidden var mColor;

    function initialize() {
        mColor = Graphics.COLOR_RED;
    }

    function getInitialView() {
        return [ new ColorView(mColor), new ColorBehaviorDelegate(self) ];
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

        // log the behavior and input that led to the transition we're
        // about to make
        System.println(Lang.format("$1$ $2$ $3$", [
            anInputName,
            BEHAVIOR_NAMES[aBehavior],
            TRANSITION_NAMES[aTransition]
        ]));

        WatchUi.switchToView(new ColorView(aColor), new ColorBehaviorDelegate(self), aTransition);

        // cache the current state
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
