import QtQuick 2.4
import QtQuick.Controls 2.0

DapTwoRoleComboBoxForm
{
    Component.onCompleted:
    {
        if(currentIndex !== -1)
        {
            //It's needed to don't update comboBox while all data will not appended
            currentIndex = -1;
            addDefaultValueToModel(firstTextRole);
            model.setProperty(0, secondTextRole, " ");
            //Set currentIndex and update comboBox
            currentIndex = 0;
        }
        else
        {
            mainLineText = checkElide(defaultMainLineText, widthPopupComboBoxNormal - (indicatorWidth + indicatorLeftInterval), Text.ElideRight);
            mainLineSecondText = "";
        }
    }

    //For set different number of roles to mainLine of opened and closed comboBox
    popup.onVisibleChanged:
    {
        checkPopupVisible(currentIndex);
    }

    delegate:
        ItemDelegate
        {
            id: comboBoxDelegate
            width: parent.width
            height: getItemHeight(index)
            property int rowWidth: textRow.width

            contentItem:
                    Rectangle
                    {
                        id: rectangleTextComboBox
                        anchors.fill: parent
                        anchors.topMargin: paddingTopItemDelegate
                        anchors.leftMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
                        anchors.rightMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
                        color: "transparent"

                        property int comboBoxIndex: index
                        property int comboBoxCurrentIndex: currentIndex

                        Row
                        {
                            id: textRow
                            width: widthPopupComboBoxNormal - ((index != currentIndex) ?
                                                                      endRowPadding :
                                                                      (indicatorWidth + indicatorLeftInterval)
                                                                  )
                            height: rectangleTextComboBox.height
                            spacing: roleInterval

                            Repeater
                            {
                                id: textRepeater
                                model: 2
                                DapText
                                {
                                    id: textComboBoxDelegate
                                    width: (textRow.width - roleInterval) / 2
                                    enabled: false
                                    fontDapText: index === 0 ? textFont : secondTextFont
                                    textColor: hovered ?
                                                   (index === 0 ? hilightColorText : hilightColorSecondText) :
                                                   (index === 0 ? normalColorText : normalColorSecondText)
                                    fullText: getModelData(rectangleTextComboBox.comboBoxIndex, (index === 0 ? firstTextRole : secondTextRole))
                                    textElide: index === 0 ? Text.ElideRight : secondTextElide
                                    horizontalAlignment: index === 0 ? Text.AlignLeft : secondTextAlign
                                    Component.onCompleted:
                                    {
                                        if(rectangleTextComboBox.comboBoxIndex === rectangleTextComboBox.comboBoxCurrentIndex)
                                        {
                                            if(index === 0)
                                                mainLineText = elText;
                                            else
                                                mainLineSecondText = elText;
                                        }
                                    }
                                }
                            }
                        }
                        onComboBoxCurrentIndexChanged:
                        {
                            if(rectangleTextComboBox.comboBoxCurrentIndex !== -1)
                                checkPopupVisible(rectangleTextComboBox.comboBoxCurrentIndex);
                        }

                    }
            background:
                Rectangle
                {
                    anchors.fill: parent
                    anchors.bottomMargin: getBackgroundSize(index)
                    color: hovered ? hilightColor : normalColor
                }

            highlighted: DapAbstractComboBox.highlightedIndex === index
        }


    //For update text at mainLine of comboBox with popup visibility
    function checkPopupVisible(currentIndex)
    {
        var mainWidth;
        //Set needed text width
        if(popup.visible)
            mainWidth = (widthPopupComboBoxNormal - (indicatorWidth + indicatorLeftInterval) - roleInterval) / 2;
        else if(!popup.visible)
            mainWidth = (isBothAtMainLine ?
                             ((widthPopupComboBoxNormal - (indicatorWidth + indicatorLeftInterval) - roleInterval) / 2) :
                             widthPopupComboBoxNormal - (indicatorWidth + indicatorLeftInterval));
        //Set font to calculate elideText for mainLineText
        dapComboBoxFontMetric.font = textFont;
        dapComboBoxTextMetric.font = textFont;
        mainLineText = checkElide(getModelData(currentIndex, firstTextRole), mainWidth, Text.ElideRight);

        //Set font to calculate elideText for mainLineSecondText
        dapComboBoxFontMetric.font = secondTextFont;
        dapComboBoxTextMetric.font = secondTextFont;
        mainLineSecondText = checkElide(getModelData(currentIndex, secondTextRole), mainWidth, secondTextElide);

    }

}
