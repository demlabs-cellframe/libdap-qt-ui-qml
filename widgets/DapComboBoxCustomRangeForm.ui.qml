import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

ComboBox
{
    id: dapComboBoxWithRange

    ///@details normalColor Item color in normal state.
    property string normalColor
    ///@detalis hilightColor Item color in selected state.
    property string hilightColor
    ///@detalis normalTopColor Top string color in normal state.
    property string normalTopColor
    ///@details hilightTopColor Top string color in selected state.
    property string hilightTopColor
    ///@details widthPopupComboBoxNormal Width of the combo box in the normal state.
    property int widthPopupComboBoxNormal
    ///@details widthPopupComboBoxActive Width of the ComboBox in the active state.
    property int widthPopupComboBoxActive
    ///@details heightComboBoxNormal Height of the ComboBox in the normal state.
    property int heightComboBoxNormal
    ///@details heightComboBoxActive Height of the ComboBox in the active state.
    property int heightComboBoxActive
    ///@details sidePaddingNormal: Sets the indent from the edge of the right and left edges of the parent in the normal state.
    property int sidePaddingNormal
    ///@details sidePaddingActive Sets the indent from the edge of the right and left edges of the parent in the active state.
    property int sidePaddingActive
    ///@details paddingTopItemDelegate Indent above from item delegate.
    property int paddingTopItemDelegate
    ///@details heightListElement List item height.
    property int heightListElement
    ///@details intervalListElement Spacing between items in a list.
    property int intervalListElement
    ///@details bottomIntervalListElement Spacing from bottom to bottom.
    property int bottomIntervalListElement
    ///@details topEffect Using an effect for the top element.
    property bool topEffect
    ///@details indicatorImageNormal Indicator picture address for normal state.
    property string indicatorImageNormal
    ///@details indicatorImageActive Indicator picture address for active state.
    property string indicatorImageActive
    ///@details indicatorWidth Indicator width.
    property int indicatorWidth
    ///@details indicatorHeight Indicator height.
    property int indicatorHeight
    ///@details indicatorLeftInterval Space between indicator border and text border.
    property int indicatorLeftInterval
    ///@details colorTopNormalDropShadow Color of the shadow effect of the combo box when minimized.
    property string colorTopNormalDropShadow
    ///@details colorDropShadow Unboxed shadow color in expanded state.
    property string colorDropShadow

    ///@details normalColorText Text color in normal state.
    property string normalColorText
    ///@details hilightColorText Text color in selected state.
    property string hilightColorText
    ///@details normalColorTopText Text color in the main line in normal state.
    property string normalColorTopText
    ///@details hilightColorTopText Text color in the main line in active state.
    property string hilightColorTopText
    ///@details unselectedRangeColorTopText Text color in the main line for "dd.mm.yyyy".
    property string unselectedRangeColorTopText
    ///@details textFont Main font of comboBox
    property var textFont
    ///@details mainLineText Text of the main line without unneccesary part.
    property string mainLineText
    ///@details isDefaultNeedToAppend Sign to add default data to the beginning of model
    property bool isDefaultNeedToAppend: false
    ///@details defaultMainLineText External value which is added to comboBox model
    property string defaultMainLineText: ""
    ///@detalis endRowPadding The width of padding at the end of one row at ComboBox where it is need.
    property int endRowPadding
    ///@details dapComboBoxTextMetric ID of comboBox Text Metric
    property alias dapComboBoxTextMetric: comboBoxTextMetric
    ///@details dapComboBoxFontMetric ID of comboBox Font Metric
    property alias dapComboBoxFontMetric: comboBoxFontMetric
    ///@details dapIsRange Sign of setting two data (range) to main line
    property bool dapIsRange: false
    ///@details dapRangeElementWidth Width of one text element of range
    property int dapRangeElementWidth
    ///@details dapRangeSpacing Space between range element and range separator
    property int dapRangeSpacing
    ///@details dapRangeDefaultText Default text - while range element will not selected
    property string dapRangeDefaultText
    ///@details dapCalendars Item with properties for two calendars: for select minimum of range and maximum of range
    property DapCalendar dapCalendars

    width: popup.visible ? widthPopupComboBoxActive : widthPopupComboBoxNormal
    height: popup.visible ? heightComboBoxActive : heightComboBoxNormal
    anchors.verticalCenter: parent.verticalCenter

    //To do elide
    TextMetrics
    {
        id: comboBoxTextMetric
        font: textFont
        elide: Text.ElideRight
    }
    // To check elide
    FontMetrics
    {
        id: comboBoxFontMetric
        font: textFont
    }

    //Icon icon near the text (arrow)
    indicator:
        Image
        {
            source: parent.popup.visible ? indicatorImageActive : indicatorImageNormal
            width: indicatorWidth
            height: indicatorHeight
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
        }

    //Defining the background for the main line
    background:
        Rectangle
        {
            anchors.fill: parent
            color: parent.popup.visible ? hilightTopColor : normalTopColor
            height: parent.height
        }

    //contentItem is setting by children
    contentItem:
        Rectangle
        {
            id: mainLineRectangle
            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
            color: "transparent"
            Rectangle
            {
                id: rectangleMinimumOfRange
                width: dapIsRange ? dapRangeElementWidth : parent.width
                height: parent.height
                color: "transparent"
                Text
                {
                    id: textMinimumOfRange
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    font: textFont
                    color: dapIsRange ?
                               (dapMinimumOfRangeCalendar.dapCalendarResult !== "" ?
                                    (popup.visible ? hilightColorTopText : normalColorTopText) :
                                    unselectedRangeColorTopText
                                ) :
                               (popup.visible ? hilightColorTopText : normalColorTopText)
                    text: dapIsRange ?
                              (dapMinimumOfRangeCalendar.dapCalendarResult !== "" ?
                                   dapMinimumOfRangeCalendar.dapCalendarResult :
                                   dapRangeDefaultText
                               ) :
                              mainLineText
                    MouseArea
                    {
                        id: mouseAreaMinimumOfRange
                        anchors.fill: parent
                        enabled: dapIsRange
                        onClicked: dapMinimumOfRangeCalendar.enabled = !dapMinimumOfRangeCalendar.enabled
                    }
                    DapCalendar
                    {
                        id: dapMinimumOfRangeCalendar
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        dapLeftPadding: dapCalendars.dapLeftPadding
                        dapRightPadding: dapCalendars.dapRightPadding
                        dapTopPadding: dapCalendars.dapTopPadding
                        dapBottomPadding: dapCalendars.dapBottomPadding
                        dapTitleTopPadding: dapCalendars.dapTitleTopPadding
                        dapTitleBottomPadding: dapCalendars.dapTitleBottomPadding
                        dapButtonInterval: dapCalendars.dapButtonInterval
                        dapTitleWidth: dapCalendars.dapTitleWidth
                        dapDayWidth: dapCalendars.dapDayWidth
                        dapDayHeight: dapCalendars.dapDayHeight
                        dapDayLeftInterval: dapCalendars.dapDayLeftInterval
                        dapDayTopInterval: dapCalendars.dapDayTopInterval
                        dapCalendarFont: dapCalendars.dapCalendarFont
                        dapCalendarBackgroundColor: dapCalendars.dapCalendarBackgroundColor
                        dapNormalTextColor: dapCalendars.dapNormalTextColor
                        dapSelectedTextColor: dapCalendars.dapSelectedTextColor
                        dapInvalidTextColor: dapCalendars.dapInvalidTextColor
                        dapNormalBackgroundColor: dapCalendars.dapNormalBackgroundColor
                        dapSelectedBackgroundColor: dapCalendars.dapSelectedBackgroundColor
                        dapDayOfWeeksFormat: dapCalendars.dapDayOfWeeksFormat
                        dapPreviousYearButtonImage: dapCalendars.dapPreviousYearButtonImage
                        dapPreviousMonthButtonImage: dapCalendars.dapPreviousMonthButtonImage
                        dapNextMonthButtonImage: dapCalendars.dapNextMonthButtonImage
                        dapNextYearButtonImage: dapCalendars.dapNextYearButtonImage
                        enabled: false
                        visible: enabled
                    }
                }

            }
            Rectangle
            {
                id: rectangleSeparator
                anchors.left: rectangleMinimumOfRange.right
                anchors.leftMargin: dapIsRange ? dapRangeSpacing : 0
                width: dapIsRange ? textSeparator.width : 0
                height: parent.height
                color: "transparent"
                Text
                {
                    id: textSeparator
                    width: contentWidth
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    font: textFont
                    color: popup.visible ? hilightColorTopText : normalColorTopText
                    text: dapIsRange ? '-' : ''
                }
            }
            Rectangle
            {
                id: rectangleMaximumOfRange
                anchors.left: rectangleSeparator.right
                anchors.leftMargin: dapIsRange ? dapRangeSpacing : 0
                width: dapIsRange ? rectangleMinimumOfRange.width : 0
                height: parent.height
                color: "transparent"
                Text
                {
                    id: textMaximumOfRange
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    font: textFont
                    color: dapIsRange ?
                               (dapMaximumOfRangeCalendar.dapCalendarResult !== "" ?
                                    (popup.visible ? hilightColorTopText : normalColorTopText) :
                                    unselectedRangeColorTopText
                                ) :
                               (popup.visible ? hilightColorTopText : normalColorTopText)
                    text: dapIsRange ?
                              (dapMaximumOfRangeCalendar.dapCalendarResult !== "" ?
                                   dapMaximumOfRangeCalendar.dapCalendarResult :
                                   dapRangeDefaultText
                               ) : ""
                    MouseArea
                    {
                        id: mouseAreaMaximumOfRange
                        anchors.fill: parent
                        enabled: dapIsRange
                        onClicked: dapMaximumOfRangeCalendar.enabled = !dapMaximumOfRangeCalendar.enabled
                    }
                    DapCalendar
                    {
                        id: dapMaximumOfRangeCalendar
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        dapLeftPadding: dapCalendars.dapLeftPadding
                        dapRightPadding: dapCalendars.dapRightPadding
                        dapTopPadding: dapCalendars.dapTopPadding
                        dapBottomPadding: dapCalendars.dapBottomPadding
                        dapTitleTopPadding: dapCalendars.dapTitleTopPadding
                        dapTitleBottomPadding: dapCalendars.dapTitleBottomPadding
                        dapButtonInterval: dapCalendars.dapButtonInterval
                        dapTitleWidth: dapCalendars.dapTitleWidth
                        dapDayWidth: dapCalendars.dapDayWidth
                        dapDayHeight: dapCalendars.dapDayHeight
                        dapDayLeftInterval: dapCalendars.dapDayLeftInterval
                        dapDayTopInterval: dapCalendars.dapDayTopInterval
                        dapCalendarFont: dapCalendars.dapCalendarFont
                        dapCalendarBackgroundColor: dapCalendars.dapCalendarBackgroundColor
                        dapNormalTextColor: dapCalendars.dapNormalTextColor
                        dapSelectedTextColor: dapCalendars.dapSelectedTextColor
                        dapInvalidTextColor: dapCalendars.dapInvalidTextColor
                        dapNormalBackgroundColor: dapCalendars.dapNormalBackgroundColor
                        dapSelectedBackgroundColor: dapCalendars.dapSelectedBackgroundColor
                        dapDayOfWeeksFormat: dapCalendars.dapDayOfWeeksFormat
                        dapPreviousYearButtonImage: dapCalendars.dapPreviousYearButtonImage
                        dapPreviousMonthButtonImage: dapCalendars.dapPreviousMonthButtonImage
                        dapNextMonthButtonImage: dapCalendars.dapNextMonthButtonImage
                        dapNextYearButtonImage: dapCalendars.dapNextYearButtonImage
                        enabled: false
                        visible: enabled
                        dapMinimumDate: dapMinimumOfRangeCalendar.dapCalendar.selectedDate
                    }
                }
            }

        }


    //Customize drop-down list with shadow effect
    popup:
        Popup
        {
            id: dapComboboxPopup
            y: parent.height - 1
            width: parent.width
            padding: 0
            contentItem:
                ListView
                {
                    id: popupList
                    clip: true
                    implicitHeight: contentHeight
                    model: popup.visible ? delegateModel : null
                    ScrollIndicator.vertical: ScrollIndicator {}
                }

            background:
                Rectangle
                {
                    width: background.width
                    color: normalColor
                    Rectangle
                    {
                        id: contentCorner
                        anchors.fill: parent
                    }

                    DropShadow
                    {
                        anchors.fill: parent
                        source: contentCorner
                        verticalOffset: 9 * pt
                        samples: 13 * pt
                        color: colorDropShadow
                    }
                }
        }

        //Shadow effect for the top element.
        DropShadow
        {
            anchors.fill: topEffect ? parent : null
            source: topEffect ? background : null
            verticalOffset: topEffect ? 9 * pt : 0
            samples: topEffect ? 13 * pt : 0
            color: topEffect ?
                       (popup.visible ? colorDropShadow : colorTopNormalDropShadow) :
                       "#000000"
            z: -1
        }
    }
