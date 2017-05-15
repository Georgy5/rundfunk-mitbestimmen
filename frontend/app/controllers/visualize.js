import Ember from 'ember';

export default Ember.Controller.extend({
  intl: Ember.inject.service(),
  chartOptions: Ember.computed('model', 'intl.locale', function() {
    return {
      chart: {
        type: 'bar',
        height: '100%',
      },
      title: {
        text: this.get('intl').t('visualize.diff-chart.title')
      },
      xAxis: {
        categories: this.get('model').get('categories')
      },
      yAxis: {
        title: {
          text: this.get('intl').t('visualize.diff-chart.yAxis.title')
        }
      },
      tooltip: {
        valueDecimals: 2,
        valueSuffix: '€'
      },
    };
  }),

  chartData: Ember.computed('model', function() {
    return this.get('model').get('series');
  }),

});
