using Toybox.WatchUi;

enum {
    BEHAVIOR_NONE,
    BEHAVIOR_NEXT_PAGE,
    BEHAVIOR_PREVIOUS_PAGE,
    BEHAVIOR_ON_MENU,
    BEHAVIOR_ON_BACK,
    BEHAVIOR_ON_NEXT_MODE,
    BEHAVIOR_ON_PREVIOUS_MODE,
    BEHAVIOR_ON_SELECT
}

const BEHAVIOR_NAMES = [
    "BEHAVIOR_NONE",
    "BEHAVIOR_NEXT_PAGE",
    "BEHAVIOR_PREVIOUS_PAGE",
    "BEHAVIOR_ON_MENU",
    "BEHAVIOR_ON_BACK",
    "BEHAVIOR_ON_NEXT_MODE",
    "BEHAVIOR_ON_PREVIOUS_MODE",
    "BEHAVIOR_ON_SELECT"
];

const KEY_NAMES = [
    "KEY_POWER",
    "KEY_LIGHT",
    "KEY_ZIN",
    "KEY_ZOUT",
    "KEY_ENTER",
    "KEY_ESC",
    "KEY_FIND",
    "KEY_MENU",
    "KEY_DOWN",
    "KEY_DOWN_LEFT",
    "KEY_DOWN_RIGHT",
    "KEY_LEFT",
    "KEY_RIGHT",
    "KEY_UP",
    "KEY_UP_LEFT",
    "KEY_UP_RIGHT",
    "EXTENDED_KEYS",
    "KEY_PAGE",
    "KEY_START",
    "KEY_LAP",
    "KEY_RESET",
    "KEY_SPORT",
    "KEY_CLOCK",
    "KEY_MODE"
];

const SWIPE_NAMES = [
    "SWIPE_UP",
    "SWIPE_RIGHT",
    "SWIPE_DOWN",
    "SWIPE_LEFT"
];

const TRANSITION_NAMES = [
    "SLIDE_IMMEDIATE",
    "SLIDE_LEFT",
    "SLIDE_RIGHT",
    "SLIDE_DOWN",
    "SLIDE_UP"
];

class ColorBehaviorDelegate extends WatchUi.BehaviorDelegate {

    private var mBehavior;
    hidden var mController;

    function initialize(aController) {
        BehaviorDelegate.initialize();
        mController = aController;
    }

    //
    // Behavior handlers. Capture the behavior, but return false
    // so that the framework will call the Input handlers below.
    //

    function onBack() {
        mBehavior = BEHAVIOR_ON_BACK;
        return false;
    }

    function onNextPage() {
        mBehavior = BEHAVIOR_NEXT_PAGE;
        return false;
    }

    function onPreviousPage() {
        mBehavior = BEHAVIOR_PREVIOUS_PAGE;
        return false;
    }

    function onSelect() {
        mBehavior = BEHAVIOR_ON_SELECT;
        return false;
    }

    function onMenu() {
        mBehavior = BEHAVIOR_ON_MENU;
        return false;
    }

    //
    // Input handlers. Cache and reset the behavior. Determine
    // the transition to use based on the input event, and then
    // handle the behavior using the given transition.
    //

    function onKey(aKeyEvent) {
        var aBehavior = mBehavior;
        mBehavior = null;

        if (aBehavior == null) {
            return false;
        }

        var aKey = aKeyEvent.getKey();

        var aTransition = getTransitionFromKey(aKey);
        if (aTransition != null) {
            return mController.switchView(aBehavior, KEY_NAMES[aKey], aTransition);
        }

        return false;
    }

    function onSwipe(aSwipeEvent) {
        var aBehavior = mBehavior;
        mBehavior = null;

        if (aBehavior == null) {
            return false;
        }

        var aDirection = aSwipeEvent.getDirection();

        var aTransition = getTransitionFromDirection(aDirection);
        if (aTransition != null) {
            return mController.switchView(aBehavior, SWIPE_NAMES[aDirection], aTransition);
        }

        return false;
    }

    function onTap(aClickEvent) {
        var aBehavior = mBehavior;
        mBehavior = null;

        if (aBehavior == null) {
            return false;
        }

        return mController.switchView(aBehavior, WatchUi.SLIDE_IMMEDIATE);
    }

    //
    // Helper function.
    //

    hidden function getTransitionFromKey(aKey) {
        if (aKey == WatchUi.KEY_UP) {
            return WatchUi.SLIDE_DOWN;
        }
        else if (aKey == WatchUi.KEY_DOWN) {
            return WatchUi.SLIDE_UP;
        }
        else if (aKey == WatchUi.KEY_LEFT) {
            return WatchUi.SLIDE_RIGHT;
        }
        else if (aKey == WatchUi.KEY_RIGHT) {
            return WatchUi.SLIDE_LEFT;
        }

        return WatchUi.SLIDE_IMMEDIATE;
    }

    //
    // Helper function.
    //

    hidden function getTransitionFromDirection(aDirection) {
        if (aDirection == WatchUi.SWIPE_DOWN) {
            return WatchUi.SLIDE_DOWN;
        }
        else if (aDirection == WatchUi.SWIPE_UP) {
            return WatchUi.SLIDE_UP;
        }
        else if (aDirection == WatchUi.SWIPE_RIGHT) {
            return WatchUi.SLIDE_RIGHT;
        }
        else if (aDirection == WatchUi.SWIPE_LEFT) {
            return WatchUi.SLIDE_LEFT;
        }

        return WatchUi.SLIDE_IMMEDIATE;
    }

}
