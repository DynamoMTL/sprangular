Sprangular.directive 'shippingRateSelection', ->
  restrict: 'E'
  templateUrl: 'shipping/rates.html'
  scope:
    order: '='

  controller: ($scope, Checkout, Env) ->
    $scope.loading = false
    $scope.address = {}
    $scope.currencySymbol = Env.currency.symbol

    $scope.$watch 'order.shippingRate', (rate, oldRate) ->
      return if !oldRate || rate.id == oldRate.id

      order = $scope.order

      if rate
        order.shipTotal = rate.cost
      else
        order.shipTotal = 0

      order.updateTotals()

      Checkout.setDelivery()

    $scope.$watch('order.shippingAddress', ->
      $scope.address = $scope.order.shippingAddress
    , true)
