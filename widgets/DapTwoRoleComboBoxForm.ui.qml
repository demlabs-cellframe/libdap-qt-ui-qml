import QtQuick 2.4

DapAbstractComboBox
{
    ///@details firstTextRole First role of comboBox model with more than one roles
    property string firstTextRole
    ///@details secondTextRole Second role of comboBox model with more than one roles
    property string secondTextRole
    ///@details isFirstElide Sign which role will elided
    property bool isFirstElide
    ///@details isBothAtMainLine Sign both role will place at mainLine of closed comboBox or only first role
    property bool isBothAtMainLine
    ///@detalis roleInterval The width between text of model roles used for the ComboBox.
    property int roleInterval

    ///@details secondTextFont Font of second role of comboBox
    property var secondTextFont
    ///@details normalColorSecondText Text color of second role in normal state.
    property string normalColorSecondText
    ///@details hilightColorSecondText Text color of second role in selected state.
    property string hilightColorSecondText
    ///@details normalColorTopSecondText Text color of second role in the main line in normal state.
    property string normalColorTopSecondText
    ///@details hilightColorTopSecondText Text color of second role in the main line in active state.
    property string hilightColorTopSecondText


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
                    model: (popup.visible) ? 2 : ((isFirstInMainLine && isSecondInMainLine) ? 2 : 1)
                    Text
                    {
                        anchors.verticalCenter: parent.verticalCenter

                        text: (popup.visible) ?
                                  mainText[index] :
                                  (isBothAtMainLine)
                        font: (popup.visible) ?
                            ((index === count) ?
                                 (index === 0 ? )
                             ) :
                                  fontComboBox[0];
                        width: popup.visible ?
                                 (topComboBoxRow.width - roleInterval * (comboBoxTextRole.length - 1)) / comboBoxTextRole.length :
                                   contentWidth
                        color: popup.visible ?
                                   colorMainTextComboBox[index][1] :
                                   colorMainTextComboBox[index][0]
                        horizontalAlignment: popup.visible ?
                                                 alignTextComboBox[index] :
                                                 Text.AlignLeft
                    }
                }
            }
            /*Text
            {
                id: cmbBxMainItemText
                width: widthPopupComboBoxNormal - (indicatorWidth + indicatorLeftInterval)
                anchors.verticalCenter: parent.verticalCenter
                enabled: false
                text: mainLineText
                font: textFont
                color: popup.visible ? hilightColorTopText : normalColorTopText
                horizontalAlignment: Text.AlignLeft
                clip: true
            }*/
        }
}
