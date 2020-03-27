import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle
{
    ///@details dapLeftPadding Set left calendar padding
    property int dapLeftPadding
    ///@details dapRightPadding Set right calendar padding
    property int dapRightPadding
    ///@details dapTopPadding Set top calendar padding
    property int dapTopPadding
    ///@details dapBottomPadding Set bottom calendar padding
    property int dapBottomPadding
    ///@details dapTitleTopPadding Set top title padding
    property int dapTitleTopPadding
    ///@details dapTitleBottomPadding  Set bottom title padding
    property int dapTitleBottomPadding
    ///@details dapButtonInterval Set interval between next/previous buttons
    property int dapButtonInterval
    ///@details dapTitleWidth Set width of title text
    property int dapTitleWidth
    ///@details dapDayWidth Set width of day element
    property int dapDayWidth
    ///@details dapDayHeight Set height of day element
    property int dapDayHeight
    ///@details dapDayLeftInterval Set space between days in one row
    property int dapDayLeftInterval
    ///@details dapDayTopInterval Set space between days in one column
    property int dapDayTopInterval
    ///@details dapCalendarFont Set text font
    property font dapCalendarFont
    ///@details dapCalendarBackgroundColor Set backgrount color for all item
    property string dapCalendarBackgroundColor
    ///@details dapNormalTextColor Set color of unselected valid text
    property string dapNormalTextColor
    ///@details dapSelectedTextColor Set color of selected text
    property string dapSelectedTextColor
    ///@details dapInvalidTextColor Set color on invalid text
    property string dapInvalidTextColor
    ///@details dapNormalBackgroundColor Set background color for day element
    property string dapNormalBackgroundColor
    ///@details dapSelectedBackgroundColor Set background color for selected day element
    property string dapSelectedBackgroundColor
    ///@details dapMinimumDate Set day elements to invalid before this date
    property var dapMinimumDate
    ///@details dapWeeksFormat Set format of day of week name
    property int dapDayOfWeeksFormat
    ///@details dapCalendarStyle Set style for all elements of calendar
    property alias dapCalendar: dapCalendar
    ///@details dapPreviousYearButtonImage Image for button "PreviousYear"
    property string dapPreviousYearButtonImage
    ///@details dapPreviousMonthButtonImage Image for button "PreviousMonth"
    property string dapPreviousMonthButtonImage
    ///@details dapNextMonthButtonImage Image for button "NextMonth"
    property string dapNextMonthButtonImage
    ///@details dapNextYearButtonImage Image for button "NextYear"
    property string dapNextYearButtonImage

    id: dapCalendarBackground
    width: dapLeftPadding + dapRightPadding + 7 * dapDayWidth + 6 * dapDayLeftInterval
    height: dapTopPadding + dapBottomPadding + dapCalendar.__style.control.height
    color: dapCalendarBackgroundColor

    Calendar
    {
        id: dapCalendar
        anchors.fill: parent
        anchors.leftMargin: dapLeftPadding
        anchors.rightMargin: dapRightPadding
        anchors.topMargin: dapTopPadding
        anchors.bottomMargin: dapBottomPadding

        frameVisible: false
    }

}

