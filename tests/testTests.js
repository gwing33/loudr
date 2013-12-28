define([
  'intern!bdd',
  'intern/chai!expect'
], function (bdd, expect) {
  with (bdd) {
    describe('demo', function () {
      // asynchronous test for Promises/A-based interfaces
      it('should be true', function () {
        expect(true).to.be.true;
      });

    });
  }
});