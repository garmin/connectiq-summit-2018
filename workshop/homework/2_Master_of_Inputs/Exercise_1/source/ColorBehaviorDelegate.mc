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

class ColorBehaviorDelegate extends WatchUi.BehaviorDelegate {

    hidden var mController;

    function initialize(aController) {
        BehaviorDelegate.initialize();
        mController = aController;
    }

    function onBack() {
        return mController.switchView(BEHAVIOR_ON_BACK);
    }

    function onNextPage() {
        return mController.switchView(BEHAVIOR_NEXT_PAGE);
    }

    function onPreviousPage() {
        return mController.switchView(BEHAVIOR_PREVIOUS_PAGE);
    }

    function onSelect() {
        return mController.switchView(BEHAVIOR_ON_SELECT);
    }
}
