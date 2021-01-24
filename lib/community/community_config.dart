abstract class CommunityConfig {
  final int communityID;

  const CommunityConfig(this.communityID);
}

class DefaultCommunity implements CommunityConfig {
  @override
  int get communityID => 1;
}
