import QtQuick 2.4
import QtQuick.Controls 2.0

DapAbstractComboBoxForm
{
    delegate:
        ItemDelegate
        {
           //Setting by children
            /*width: parent.width

            //Adjusting the height of the line, taking into account that the second element from the end may be the last
            //height: getItemHeight(index)

            //contentItem is setting by children

            //Indent from the bottom edge or the next line that will not stand out when you hover over the mouse
            background:
                Rectangle
                {
                    anchors.fill: parent
                    anchors.bottomMargin: getBackgroundSize(index)
                    color: hovered ? hilightColor : normalColor
                }


            highlighted: parent.highlightedIndex === index*/
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

}
