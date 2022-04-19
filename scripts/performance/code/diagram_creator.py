from pandas import DataFrame, Series

def createPieChart(data, labels, title, savePath):
    labels = ['{0} - {1:1.2f} %'.format(i, j) for i, j in zip(labels, data)]

    series = Series(data=data, name="")

    f = series.plot.pie(labels=None, shadow=True, title=title) \
        .legend(labels) \
        .get_figure()
    f.savefig(savePath, bbox_inches='tight')
    f.clear()
