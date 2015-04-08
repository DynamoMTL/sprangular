Sprangular.controller 'CheckoutCtrl', (
  $scope,
  $location,
  countries,
  order,
  Status,
  Account,
  Cart,
  Checkout,
  Angularytics,
  Env,
  $translate
) ->
  Status.setPageTitle('checkout.checkout')

  user = Account.user

  $scope.order = order
  $scope.secure = $location.protocol() == 'https'
  $scope.currencySymbol = Env.currency.symbol
  $scope.shippingAddress = {}
  $scope.billingAddress = {}
  $scope.shippingValid = false
  $scope.billingValid = false
  $scope.isValid = false
  Cart.lastOrder = null

  if !Account.isGuest
    $scope.user = user = Account.user
    order.resetAddresses(user)
    order.resetCreditCard(user)
  else
    $scope.user = user = {}

  $scope.removeAdjustment = (adjustment) ->
    Angularytics.trackEvent("Cart", "Coupon removed", adjustment.promoCode())
    Cart.removeAdjustment(adjustment)
