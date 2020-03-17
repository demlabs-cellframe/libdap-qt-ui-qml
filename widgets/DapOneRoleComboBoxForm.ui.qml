import QtQuick 2.4

DapSimpleComboBox
{

    id: dapOneRoleComboBox

    ///@details textRole One role of comboBox model with more than one roles
    property string oneTextRole: "text"

    //Text item
    contentItem:
        Rectangle
        {
            id: mainRectangle
            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
            color: "transparent"

            Text
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
            }
        }

}
