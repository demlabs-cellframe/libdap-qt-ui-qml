import QtQuick 2.4
import QtQuick.Controls 2.0


DapComboBoxCustomRangeForm
{
    Component.onCompleted:
    {
        if(currentIndex !== -1)
        {
            currentIndex = -1;
            addDefaultValueToModel("name");
            currentIndex = 0;
            mainLineText = checkElide(textAt(currentIndex), widthPopupComboBoxNormal - (indicatorWidth + indicatorLeftInterval), Text.ElideRight);
        }
        else
            mainLineText = checkElide(defaultMainLineText, widthPopupComboBoxNormal - (indicatorWidth + indicatorLeftInterval), Text.ElideRight);
    }


    delegate:
        ItemDelegate
        {
            width: parent.width
            height:
            {
                if(index !== currentIndex)
                {
                        if(index === (count - 2))
                        {
                            if(index+1 === currentIndex)
                                return heightListElement + bottomIntervalListElement;
                            else
                                return heightListElement + intervalListElement;
                        }
                        if (index === count - 1)
                            return heightListElement + bottomIntervalListElement;
                        return heightListElement + intervalListElement;
                    }
                    else return 0;
            }

            contentItem:
                Rectangle
                {
                    id: rectangleTextComboBox
                    anchors.fill: parent
                    anchors.topMargin: paddingTopItemDelegate
                    anchors.leftMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
                    anchors.rightMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
                    color: "transparent"
                    DapText
                    {
                        id: cmbBxItemText
                        width: parent.width - ((index != currentIndex) ?
                                                   0 :
                                                   (indicatorWidth + indicatorLeftInterval)
                                               )
                        height: rectangleTextComboBox.height
                        enabled: false
                        fontDapText: textFont
                        textColor: hovered ? hilightColorText : normalColorText
                        horizontalAlignment: Text.AlignLeft
                        textElide: Text.ElideRight
                        fullText: getModelData(index, "name")
                        clip: true
                    }
                }

                background:
                    Rectangle
                    {
                        anchors.fill: parent
                        anchors.bottomMargin:
                        {
                            if(index === count - 2)
                            {
                                if(index+1 === currentIndex)
                                    return bottomIntervalListElement;
                                else
                                    return intervalListElement;
                            }
                            if (index === count - 1)
                                return bottomIntervalListElement;
                            return intervalListElement;
                        }
                        color: hovered ? hilightColor : normalColor
                    }

                highlighted: highlightedIndex === index
            }


    onCurrentIndexChanged:
    {
        if(currentIndex === -1)
            mainLineText = checkElide(defaultMainLineText, widthPopupComboBoxNormal - (indicatorWidth + indicatorLeftInterval), Text.ElideRight);
        else
        {
            if(textAt(currentIndex).indexOf("custom") !== -1)
            {
                dapIsRange = true;
            }
            else
            {
                dapIsRange = false;
                mainLineText = checkElide(textAt(currentIndex), widthPopupComboBoxNormal - (indicatorWidth + indicatorLeftInterval), Text.ElideRight);
            }
        }
    }


    //To get modelData from model with more than one roles
    function getModelData(rowIndex, modelRole)
    {
        if(rowIndex !== -1)
            return model.get(rowIndex)[modelRole];
        return " ";
    }

    //To add default n=value to comboBox model
    function addDefaultValueToModel(oneTextRole)
    {
        if(isDefaultNeedToAppend && model.get(0, oneTextRole) !== defaultMainLineText)
        {
            model.insert(0, {});
            model.setProperty(0, oneTextRole, defaultMainLineText)
        }
    }

    //To check ability of adding one more letter to elided text in main line by text and mode
    function checkElide(text1, width1, mode)
    {
        dapComboBoxTextMetric.text = text1;
        dapComboBoxTextMetric.elideWidth = width1;
        dapComboBoxTextMetric.elide = mode;
        //Index of cut
        var indexOfChar = -1;
        //Temp string without cutting part
        var firstString = "";
        if(width1 < dapComboBoxFontMetric.tightBoundingRect(text1).width)
        {
            if(mode === Text.ElideRight)
            {
                indexOfChar = dapComboBoxTextMetric.elidedText.length - 1;
                firstString = dapComboBoxTextMetric.elidedText.substring(0, indexOfChar);
                if(dapComboBoxFontMetric.tightBoundingRect(firstString + '..').width < width1)
                {
                    if(dapComboBoxFontMetric.tightBoundingRect(firstString + dapComboBoxTextMetric.text.charAt(indexOfChar) + '..').width < width1)
                        return firstString + dapComboBoxTextMetric.text.charAt(indexOfChar) + '..';
                    else
                        return firstString + '..';
                }
                else
                {
                    indexOfChar--;
                    return dapComboBoxTextMetric.elidedText.substring(0, indexOfChar) + '..';
                }

            }
            if(mode === Text.ElideMiddle)
            {
                indexOfChar = dapComboBoxTextMetric.elidedText.indexOf('…');
                //Index of char after '…'
                var indexOfNextChar = indexOfChar + 1;
                if(indexOfChar !== -1)
                {
                    firstString = dapComboBoxTextMetric.elidedText.substring(0, indexOfChar);
                    if(dapComboBoxFontMetric.tightBoundingRect(firstString + '..' + dapComboBoxTextMetric.elidedText.substring(indexOfNextChar, dapComboBoxTextMetric.elidedText.length)).width < width1)
                        return firstString + '..' + dapComboBoxTextMetric.elidedText.substring(indexOfNextChar, dapComboBoxTextMetric.elidedText.length);
                    else
                    {
                        indexOfChar--;
                        firstString = dapComboBoxTextMetric.elidedText.substring(0, indexOfChar);
                        if(dapComboBoxFontMetric.tightBoundingRect(firstString + '..' + dapComboBoxTextMetric.elidedText.substring(indexOfNextChar, dapComboBoxTextMetric.elidedText.length)).width < width1)
                            return firstString + '..' + dapComboBoxTextMetric.elidedText.substring(indexOfNextChar, dapComboBoxTextMetric.elidedText.length);
                        else
                            return firstString + '..' + dapComboBoxTextMetric.elidedText.substring(indexOfNextChar, dapComboBoxTextMetric.elidedText.length);
                    }
                }
                else
                    return text1;
            }
            if(mode === Text.ElideLeft)
            {
                indexOfChar = dapComboBoxTextMetric.elidedText.length;
                firstString = dapComboBoxTextMetric.elidedText.substring(1, indexOfChar);
                if(dapComboBoxFontMetric.tightBoundingRect('..' + firstString).width < width1)
                {
                    if(dapComboBoxFontMetric.tightBoundingRect('..' + dapComboBoxTextMetric.text.charAt(dapComboBoxTextMetric.text.length - dapComboBoxTextMetric.elidedText.length) + firstString).width < width1)
                        return '..' + dapComboBoxTextMetric.text.charAt(dapComboBoxTextMetric.text.length - dapComboBoxTextMetric.elidedText.length) + firstString;
                    else
                        return '..' + firstString;
                }
                else
                    return '..' + dapComboBoxTextMetric.elidedText.substring(2, indexOfChar);
            }
        }
        else
            return text1;
    }




}
