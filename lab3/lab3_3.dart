class Client {
  final String _name;
  late double _amount;

  Client(this._name);

  // getter for the purchase amount
  double get purchaseAmount => _amount;

  // setter for the purchase amount
  set purchaseAmount(double value) {
    _amount = value;
  }

  @override
  String toString() {
    return "Client: $_name\nPurchase amount: $_amount";
  }
}

class LoyalClient extends Client {
  final double _discountLoyal = 0.1;

  LoyalClient(super.name);

  double get purchaseAmountLoyal => super.purchaseAmount;

  discount() {
    super._amount = super._amount * (1 - _discountLoyal);
  }

  @override
  String toString() {
    return "Loyal client: ${super._name}\nPurchase amount: $_amount";
  }
}

void main() {
  Client client = Client("Cecilia");
  client.purchaseAmount = 100;
  print(client);

  LoyalClient loyalClient = LoyalClient("Valentina");
  loyalClient.purchaseAmount = 100;
  print(loyalClient);

  loyalClient.discount();
  print(loyalClient);
}