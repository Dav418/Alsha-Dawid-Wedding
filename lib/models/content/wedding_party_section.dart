enum WeddingPartySection {
  bridesmaids('BRIDESMAIDS'),
  bridesquad('BRIDE SQUAD'),
  groomsmen('GROOMSMEN'),
  parents('PARENTS'),
  flowerGirls('FLOWER GIRLS'),
  pageBoys('PAGE BOYS'),
  maidOfHonor('MAID OF HONOR'),
  bestMan('BEST MAN'),
  dogs('PAWS OF HONOR');

  const WeddingPartySection(this.title);

  final String title;
}
