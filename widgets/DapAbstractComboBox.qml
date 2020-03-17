import QtQuick 2.4
import QtQuick.Controls 2.0

DapAbstractComboBoxForm
{

    delegate:
        ItemDelegate
        {
           //Setting by children
        }

    //For using by children to set item height
    function getItemHeight(index)
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

    //For using by children to set item background size
    function getBackgroundSize(index)
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

    //For using by children to get modelData from model with more than one roles
    function getModelData(rowIndex, modelRole)
    {
        return model.get(rowIndex)[modelRole];
    }

    //For using by children to add string from defaultMainLineText to the comboBox model
    function addDefaultValueToModel(oneTextRole)
    {
        if(isDefaultNeedToAppend && model.get(0, oneTextRole) !== defaultMainLineText)
        {
            model.insert(0, {});
            model.setProperty(0, oneTextRole, defaultMainLineText)
        }
    }

    //For using by children to check ability of adding one more letter to elided text
    function checkElide(currentIndex)
    {
        dapComboBoxTextMetric.text = textAt(currentIndex);
        dapComboBoxTextMetric.elideWidth = widthPopupComboBoxNormal - (indicatorWidth + indicatorLeftInterval);
        if(dapComboBoxTextMetric.elideWidth < dapComboBoxFontMetric.tightBoundingRect(dapComboBoxTextMetric.text).width)
            return dapComboBoxTextMetric.elidedText.substring(0, dapComboBoxTextMetric.elidedText.length - 1) +
                    ((dapComboBoxFontMetric.tightBoundingRect(dapComboBoxTextMetric.elidedText.substring(0, dapComboBoxTextMetric.elidedText.length - 1)).width +
                      dapComboBoxFontMetric.tightBoundingRect(dapComboBoxTextMetric.text.charAt(dapComboBoxTextMetric.elidedText.length - 1) + '..').width) < dapComboBoxTextMetric.elideWidth ?
                         (dapComboBoxTextMetric.text.charAt(dapComboBoxTextMetric.elidedText.length - 1) + '..') :
                       '..');
        else
            return dapComboBoxTextMetric.elidedText.replace('…', '..');
    }

    //For using by children to check ability of adding one more letter to elided text by text and mode
    function checkElideRole(text1, width1, mode)
    {
        dapComboBoxTextMetric.text = text1;
        dapComboBoxTextMetric.elideWidth = width1;
        dapComboBoxTextMetric.elide = mode;
        var indexOfChar = dapComboBoxTextMetric.elidedText.indexOf('…');
        if(width1 < dapComboBoxFontMetric.tightBoundingRect(text1).width)
        {
            if(mode === Text.ElideRight)
                return dapComboBoxTextMetric.elidedText.substring(0, dapComboBoxTextMetric.elidedText.length - 1) +
                        ((dapComboBoxFontMetric.tightBoundingRect(dapComboBoxTextMetric.elidedText.substring(0, dapComboBoxTextMetric.elidedText.length - 1)).width +
                          dapComboBoxFontMetric.tightBoundingRect(dapComboBoxTextMetric.text.charAt(dapComboBoxTextMetric.elidedText.length - 1) + '..').width) < dapComboBoxTextMetric.elideWidth ?
                             (dapComboBoxTextMetric.text.charAt(dapComboBoxTextMetric.elidedText.length - 1) + '..') :
                           '..');

            if(mode === Text.ElideMiddle)
            {
                if(dapComboBoxTextMetric.elidedText.indexOf('…') !== -1)
                    return dapComboBoxTextMetric.elidedText.substring(0, indexOfChar) +
                            ((dapComboBoxFontMetric.tightBoundingRect(dapComboBoxTextMetric.elidedText.substring(0, indexOfChar)).width +
                              dapComboBoxFontMetric.tightBoundingRect(dapComboBoxTextMetric.text.charAt(indexOfChar) + '..').width +
                              dapComboBoxFontMetric.tightBoundingRect(dapComboBoxTextMetric.elidedText.substring(indexOfChar + 1, dapComboBoxTextMetric.elidedText.length)).width) < dapComboBoxTextMetric.elideWidth ?
                                 (dapComboBoxTextMetric.text.charAt(indexOfChar) + '..'):
                                 '..') +
                            dapComboBoxTextMetric.elidedText.substring(indexOfChar + 1, dapComboBoxTextMetric.elidedText.length);

            }
        }
        else
            return dapComboBoxTextMetric.elidedText.replace('…', '..');
    }

}
