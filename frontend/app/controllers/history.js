import Ember from 'ember';

export default Ember.Controller.extend({
  session: Ember.inject.service('session'),
  queryParams: ["page", "perPage"],

  totalPagesBinding: Ember.computed.alias("content.totalPages"),

  page: 1,
  perPage: 10,
  actions: {
    pageClicked(page) {
      this.set('page', page);
    },
    unselect(broadcast){
      let impression = broadcast.respond('neutral');
      impression.save();
    },
    reselect(broadcast){
      let impression = broadcast.respond('positive');
      impression.save();
    },
  }
});
