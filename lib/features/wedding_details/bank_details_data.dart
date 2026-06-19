enum BankAccountRegion {
  polish,
  english,
  indian,
}

class BankDetailField {
  const BankDetailField({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
}

class BankAccountDetails {
  const BankAccountDetails({
    required this.region,
    required this.fields,
  });

  final BankAccountRegion region;
  final List<BankDetailField> fields;
}

const bankAccounts = {
  BankAccountRegion.polish: BankAccountDetails(
    region: BankAccountRegion.polish,
    fields: [
      BankDetailField(label: 'Bank name', value: 'Wise Payments Limited'),
      BankDetailField(
          label: 'Account holder name',
          value: 'Mr Dawid Gorski & Ms Alisha Fernandes'),
      BankDetailField(label: 'IBAN', value: 'GB67TRWI60846446155337'),
      BankDetailField(label: 'SWIFT / BIC', value: 'TRWIGB2LXXX'),
    ],
  ),
  BankAccountRegion.english: BankAccountDetails(
    region: BankAccountRegion.english,
    fields: [
      BankDetailField(label: 'Bank name', value: 'Barclays Bank UK'),
      BankDetailField(
        label: 'Account holder name',
        value: 'Mr Dawid Gorski & Ms Alisha Fernandes',
      ),
      BankDetailField(label: 'Sort code', value: '20-00-00'),
      BankDetailField(label: 'Account number', value: '12345678'),
      BankDetailField(label: 'IBAN', value: 'GB29 BARC 2000 0012 3456 78'),
    ],
  ),
  BankAccountRegion.indian: BankAccountDetails(
    region: BankAccountRegion.indian,
    fields: [
      BankDetailField(label: 'Bank name', value: 'HDFC Bank'),
      BankDetailField(
          label: 'Account holder name',
          value: 'Mr Dawid Gorski & Ms Alisha Fernandes'),
      BankDetailField(label: 'Account number', value: '50100 12345678'),
      BankDetailField(label: 'IFSC code', value: 'HDFC0001234'),
      BankDetailField(label: 'Branch', value: 'Panaji, Goa'),
    ],
  ),
};
