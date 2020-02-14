import QtQuick 2.4
import QtQuick.Controls 2.0

DapComboBoxForm
{
    delegate:
        ItemDelegate
        {
            width: parent.width

            //Adjusting the height of the line, taking into account that the second element from the end may be the last
            height:
                {
                    if(index != currentIndex)
                    {
                        if(index == (count - 2))
                        {
                            if(index+1 == currentIndex)
                                return heightListElement + bottomIntervalListElement
                            else
                                return heightListElement + intervalListElement
                        }
                        if (index == count - 1)
                            return heightListElement + bottomIntervalListElement
                        return heightListElement + intervalListElement
                    }
                    else return 0
                }

            //Text item
            contentItem:
                Rectangle
                {
                    id: rectangleTextComboBox

                    anchors.fill: parent
                    anchors.topMargin: paddingTopItemDelegate
                    anchors.leftMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
                    anchors.rightMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
                    border.width: 1
                    color: "transparent"

                    FontMetrics
                    {
                        id: comboBoxFontMetric
                        font: fontComboBox
                    }
                    property int comboBoxIndex: index
                    property int comboBoxCurrentIndex: currentIndex
                    Row
                    {
                        id: textRow
                        width: rectangleTextComboBox.width - ((index != currentIndex) ?
                                                                  endRowPadding :
                                                                  (indicatorWidth + indicatorLeftInterval)
                                                              )
                        height: rectangleTextComboBox.height
                        spacing: roleInterval
                        Repeater
                        {
                            id: textRepeater
                            model: comboBoxTextRole.length
                            DapText
                            {
                                id: textComboBoxDelegate
                                width: (textRow.width - roleInterval * (comboBoxTextRole.length - 1)) / comboBoxTextRole.length
                                enabled: false
                                fontDapText: fontComboBox
                                textColor: hovered ? hilightColorText : normalColorText
                                fullText: getModelData(rectangleTextComboBox.comboBoxIndex, comboBoxTextRole[index])

                                Component.onCompleted:
                                {
                                   if(rectangleTextComboBox.comboBoxIndex == rectangleTextComboBox.comboBoxCurrentIndex)
                                   {
                                       var tmp = mainRow;
                                       tmp[index] = elText;
                                       mainRow = tmp;

                                       if(index == 0)
                                           mainLineText = comboBoxFontMetric.elidedText(fullText, Text.ElideRight, rectangleTextComboBox.width, Qt.TextShowMnemonic);
                                   }
                                }

                            }
                        }

                    }
                    onComboBoxCurrentIndexChanged:
                    {
                        mainLineText = comboBoxFontMetric.elidedText(getModelData(currentIndex, comboBoxTextRole[0]), Text.ElideRight, rectangleTextComboBox.width, Qt.TextShowMnemonic);
                        console.log("mainLineText", mainLineText)
                    }
                }



            //Indent from the bottom edge or the next line that will not stand out when you hover over the mouse
            background:
                Rectangle
                {
                    anchors.fill: parent
                    anchors.bottomMargin: {
                        if(index == count - 2)
                        {
                            if(index+1 == currentIndex)
                                return bottomIntervalListElement
                            else
                                return intervalListElement
                        }
                        if (index == count - 1)
                            return bottomIntervalListElement
                        return intervalListElement
                    }
                    color: hovered ? hilightColor : normalColor
                }
            highlighted: parent.highlightedIndex === index
        }

    function checkElidedText(fontMetric, textMetric)
    {
        return textMetric.elidedText.substring(0, textMetric.elidedText.length-1) +
                ((fontMetric.tightBoundingRect(textMetric.elidedText.substring(0, textMetric.elidedText.length-1)).width +
                  fontMetric.tightBoundingRect(textMetric.text.charAt(textMetric.elidedText.length-1) + '..').width) < textMetric.elideWidth ?
                     (textMetric.text.charAt(textMetric.elidedText.length-1) + '..')
                   : '..');
    }

    function getModelData(rowIndex, modelRole)
    {
        return model.get(rowIndex)[modelRole];
    }

    function setModelDataWidth(rowIndex, fontMetric, rowWidth)
    {
        comboBoxTextRoleWidth = [0];
        mainLineText = [""];
        var neededWidth = 0;
        for(var i = 0; i < comboBoxTextRole.length; i++)
        {
            mainLineText[i] = "";
            comboBoxTextRoleWidth[i] = fontMetric.tightBoundingRect(getModelData(rowIndex, comboBoxTextRole[i])).width;
            neededWidth += comboBoxTextRoleWidth[i];
        }
        neededWidth += roleInterval * (comboBoxTextRole.length - 1);
        console.log("neededWidth", neededWidth, "rowWidth", rowWidth);
        var oneIndex = 0;
        if (neededWidth > rowWidth)
        {
            oneIndex = comboBoxTextRole.indexOf(mainLineRole);
            if(oneIndex === -1)
            {
                oneIndex = comboBoxTextRole.indexOf("text");
                if(oneIndex === -1)
                {
                    oneIndex = comboBoxTextRole.indexOf("name");
                    if(oneIndex === -1)
                        oneIndex = 0;
                }
            }
            if(comboBoxTextRoleWidth[oneIndex] < neededWidth - rowWidth)
            {
                comboBoxTextRoleWidth[oneIndex] = rowWidth / (comboBoxTextRole.length);
                var maxWidth = 0;
                var maxIndex = 0;
                while(neededWidth > rowWidth)
                {
                    maxWidth = comboBoxTextRoleWidth[0];
                    maxIndex = 0;
                    for(i = 0; i < comboBoxTextRoleWidth.length; i++)
                    {
                        if(maxWidth < comboBoxTextRoleWidth[i])
                        {
                            maxWidth = comboBoxTextRoleWidth[i];
                            maxIndex = i;
                        }
                    }
                    comboBoxTextRoleWidth[maxIndex] -= 10 * pt;
                    neededWidth = 0;
                    for(i = 0; i < comboBoxTextRoleWidth.length; i++)
                        neededWidth += comboBoxTextRoleWidth[i];
                }
            }
            return true;
        }
        if(neededWidth < rowWidth)
        {
            oneIndex = comboBoxTextRole.indexOf(mainLineRole);
            if(oneIndex === -1)
            {
                oneIndex = comboBoxTextRole.indexOf("text");
                if(oneIndex === -1)
                {
                    oneIndex = comboBoxTextRole.indexOf("name");
                    if(oneIndex === -1)
                        oneIndex = 0;
                }
            }
            comboBoxTextRoleWidth[oneIndex] += rowWidth - neededWidth;
            return true;
        }
        return false;
    }

}
