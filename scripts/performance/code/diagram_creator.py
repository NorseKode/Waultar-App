from pandas import DataFrame, Series

def createPieChart(data, labels, title, savePath):
    series = Series(data=data, index=labels, name="")

    series.plot.pie(autopct="%.2f%%", legend=True, shadow=True, title=title).get_figure().savefig(savePath)
