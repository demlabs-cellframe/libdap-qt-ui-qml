import QtQuick 2.4

DapAbstractComboBox
{
    ///@details firstTextRole First role of comboBox model with more than one roles
    property string firstTextRole
    ///@details secondTextRole Second role of comboBox model with more than one roles
    property string secondTextRole
    ///@details isBothAtMainLine Sign both role will place at mainLine of closed comboBox or only first role
    property bool isBothAtMainLine: false
    ///@detalis roleInterval The width between text of model roles used for the ComboBox.
    property int roleInterval: 5

    ///@details secondTextFont Font of second role of comboBox
    property var secondTextFont: textFont
    ///@details mainLineSecondText Text of second role of comboBox main line
    property string mainLineSecondText
    ///@details normalColorSecondText Text color of second role in normal state.
    property string normalColorSecondText: normalColorText
    ///@details hilightColorSecondText Text color of second role in selected state.
    property string hilightColorSecondText: hilightColorText
    ///@details normalColorTopSecondText Text color of second role in the main line in normal state.
    property string normalColorTopSecondText: normalColorTopText
    ///@details hilightColorTopSecondText Text color of second role in the main line in active state.
    property string hilightColorTopSecondText: hilightColorTopText
    ///@details secondTextAlign Alidn rules for text of second role
    property int secondTextAlign: Text.AlignRight
    ///@details SecondTextElide Elide rules for text of second role
    property int secondTextElide: Text.ElideMiddle

    id: dapTwoRoleComboBox


    //Text item
    contentItem:
        Rectangle
        {
            id: mainRectangle
            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
            color: "transparent"

            Row
            {
                id: topComboBoxRow
                width: widthPopupComboBoxNormal - indicatorWidth - indicatorLeftInterval
                height: mainRectangle.height
                spacing: roleInterval
                Repeater
                {
                    id: textCurrentRepeater
                    model: (popup.visible) ? 2 : ((isBothAtMainLine) ? 2 : 1)
                    Text
                    {
                        id: cmbBxMainItemText
                        anchors.verticalCenter: parent.verticalCenter
                        enabled: false
                        text: (popup.visible) ?
                                  (index === 0 ? mainLineText : mainLineSecondText) :
                                  (isBothAtMainLine ? (index === 0 ? mainLineText : mainLineSecondText) : mainLineText)
                        font: (popup.visible) ?
                                  (index === 0 ? textFont : secondTextFont) :
                                  (isBothAtMainLine ? (index === 0 ? textFont : secondTextFont) : textFont)
                        width:(popup.visible) ?
                                   ((topComboBoxRow.width - roleInterval) / textCurrentRepeater.count) :
                                   (isBothAtMainLine ? ((topComboBoxRow.width - roleInterval) / textCurrentRepeater.count) : contentWidth)
                        color: (popup.visible) ?
                                   (index === 0 ? hilightColorTopText : hilightColorTopSecondText) :
                                   (isBothAtMainLine ? (index === 0 ? normalColorTopText : normalColorTopSecondText) : normalColorTopText)
                        horizontalAlignment: popup.visible ?
                                                 (index === 0 ? Text.AlignLeft : Text.AlignRight) :
                                                 (isBothAtMainLine ? (index === 0 ? Text.AlignLeft : Text.AlignRight) : Text.AlignLeft)
                    }
                }
            }
        }
}
