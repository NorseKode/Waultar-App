from pandas import DataFrame, Series

def createPieChart(data, labels, title, savePath):
    series = Series(data=data, index=labels, name="")

    f = series.plot.pie(autopct="%.2f%%", legend=True,  shadow=True, title=title) \
        .legend(loc='center right', bbox_to_anchor=(0.06, 1)) \
        .get_figure()
    f.savefig(savePath)
    f.clear()
