using Toybox.Graphics;
using Toybox.Lang;
using Toybox.Test;

(:test) module testColorController
{
    // aliases to reduce typing
    const RED      = Graphics.COLOR_RED;
    const GREEN    = Graphics.COLOR_GREEN;
    const DK_RED   = Graphics.COLOR_DK_RED;
    const DK_GREEN = Graphics.COLOR_DK_GREEN;

    // aliases to reduce typing
    const NEXT_MODE = BEHAVIOR_ON_NEXT_MODE;
    const NEXT_PAGE = BEHAVIOR_NEXT_PAGE;
    const ON_BACK   = BEHAVIOR_ON_BACK;
    const ON_MENU   = BEHAVIOR_ON_MENU;
    const ON_SELECT = BEHAVIOR_ON_SELECT;
    const PREV_MODE = BEHAVIOR_ON_PREVIOUS_MODE;
    const PREV_PAGE = BEHAVIOR_PREVIOUS_PAGE;

    // for message readability
    const COLOR_NAMES = {
        GREEN    => "GREEN",
        RED      => "RED",
        DK_GREEN => "DARK_GREEN",
        DK_RED   => "DARK_RED",
    };

    // for message readability
    const BEHAVIOR_NAMES = {
        BEHAVIOR_NONE             => "NONE",
        BEHAVIOR_NEXT_PAGE        => "NEXT_PAGE",
        BEHAVIOR_PREVIOUS_PAGE    => "PREV_PAGE",
        BEHAVIOR_ON_BACK          => "ON_BACK",
        BEHAVIOR_ON_MENU          => "ON_MENU",
        BEHAVIOR_ON_SELECT        => "ON_SELECT",
        BEHAVIOR_ON_NEXT_MODE     => "NEXT_MODE",
        BEHAVIOR_ON_PREVIOUS_MODE => "PREV_MODE",
    };

    function COLOR_NAME(aColor) {
        var aName = COLOR_NAMES[aColor];
        if (aName == null) {
            aName = aColor.format("%06X");
        }
        return aName;
    }

    function BEHAVIOR_NAME(aBehavior) {
        var aName = BEHAVIOR_NAMES[aBehavior];
        if (aName == null) {
            aName = aName.toString();
        }

        return aName;
    }

    // verify the initial view is the red view
    (:test) function testGetInitialView(logger) {
        var aController = new ColorController();
        Test.assertNotEqual(aController, null);

        var anInitialView = aController.getInitialView();
        Test.assertNotEqual(anInitialView, null);

        var success = true;

        success = success && (anInitialView[0] instanceof RedView);
        success = success && (anInitialView[1] instanceof ColorBehaviorDelegate);

        return success;
    }

    // transitions from the red view
    (:test) function testRedTransitions(logger) {
        var success = true;

        success = success && testNextViewColor(logger, RED, BEHAVIOR_PREVIOUS_PAGE,  null,   null);
        success = success && testNextViewColor(logger, RED,     BEHAVIOR_NEXT_PAGE,  true,  GREEN);
        success = success && testNextViewColor(logger, RED,     BEHAVIOR_NEXT_PAGE, false,   null);
        success = success && testNextViewColor(logger, RED,     BEHAVIOR_ON_SELECT,  null, DK_RED);

        return success;
    }

    // transitions from the green view
    (:test) function testGreenTransitions(logger) {
        var success = true;

        success = success && testNextViewColor(logger, GREEN, BEHAVIOR_PREVIOUS_PAGE, null,      RED);
        success = success && testNextViewColor(logger, GREEN,     BEHAVIOR_NEXT_PAGE, null,     null);
        success = success && testNextViewColor(logger, GREEN,     BEHAVIOR_ON_SELECT, null, DK_GREEN);

        return success;
    }

    (:test) function testDarkRedTransitions(logger) {
        var success = true;

        success = success && testNextViewColor(logger, DK_RED, BEHAVIOR_PREVIOUS_PAGE, null, null);
        success = success && testNextViewColor(logger, DK_RED,     BEHAVIOR_NEXT_PAGE, null, null);
        success = success && testNextViewColor(logger, DK_RED,     BEHAVIOR_ON_SELECT, null, null);
        success = success && testNextViewColor(logger, DK_RED,       BEHAVIOR_ON_BACK, null, RED);

        return success;
    }

    (:test) function testDarkGreenTransitions(logger) {
        var success = true;

        success = success && testNextViewColor(logger, DK_GREEN, BEHAVIOR_PREVIOUS_PAGE, null,  null);
        success = success && testNextViewColor(logger, DK_GREEN,     BEHAVIOR_NEXT_PAGE, null,  null);
        success = success && testNextViewColor(logger, DK_GREEN,     BEHAVIOR_ON_SELECT, null,  null);
        success = success && testNextViewColor(logger, DK_GREEN,       BEHAVIOR_ON_BACK, null, GREEN);

        return success;
    }

    (:test) function testNextViewColorAsserts(logger) {
        var success = true;

        success = success && testNextViewColorThrowsAssert(logger, Graphics.COLOR_PURPLE, BEHAVIOR_PREVIOUS_PAGE);
        success = success && testNextViewColorThrowsAssert(logger, Graphics.COLOR_PURPLE,     BEHAVIOR_NEXT_PAGE);
        success = success && testNextViewColorThrowsAssert(logger, Graphics.COLOR_PURPLE,     BEHAVIOR_ON_SELECT);
        success = success && testNextViewColorThrowsAssert(logger, Graphics.COLOR_PURPLE,       BEHAVIOR_ON_BACK);
        success = success && testNextViewColorThrowsAssert(logger, Graphics.COLOR_PURPLE,       BEHAVIOR_ON_MENU);

        return success;
    }


    function testNextViewColor(aLogger, aColor, aBehavior, hasGreen, anExpectedColor) {
        var aController = new ColorController();
        Test.assertNotEqual(aController, null);

        var aResultColor = aController.nextViewColor(aColor, aBehavior, hasGreen);
        if (aResultColor != anExpectedColor) {

            if (anExpectedColor == null) {
                aMessage = Lang.format("$1$ from $2$ should return null", [
                    BEHAVIOR_NAME(aBehavior),
                    COLOR_NAME(aColor)
                ]);
            }
            else {
                aMessage = Lang.format("$1$ from $2$ gives $3$, should be $4$", [
                    BEHAVIOR_NAME(aBehavior),
                    COLOR_NAME(aColor),
                    COLOR_NAME(anExpectedColor),
                    COLOR_NAME(aResultColor),
                ]);
            }

            aLogger.error(aMessage);

            return false;
        }

        return true;
    }

    function testNextViewColorThrowsAssert(aLogger, aColor, aBehavior) {
        var aController = new ColorController();

        try {
            aController.nextViewColor(aColor, aBehavior, true);
        }
        catch (ex instanceof Test.AssertException) {
            return true;
        }

        return false;
    }

}
