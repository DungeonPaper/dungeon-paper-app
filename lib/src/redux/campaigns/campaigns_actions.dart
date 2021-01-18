part of 'campaigns_store.dart';

class SetCampaigns {
  final Map<String, Campaign> campaigns;
  SetCampaigns(this.campaigns);

  factory SetCampaigns.fromIterable(Iterable<Campaign> iterable) =>
      SetCampaigns({
        for (final cmp in iterable) cmp.documentID: cmp,
      });
}

class UpsertCampaign {
  final Campaign campaign;
  UpsertCampaign(this.campaign);
}

class RemoveCampaign {
  final Campaign campaign;
  RemoveCampaign(this.campaign);
}

class GetCampaigns {}

class CampaignsActions {
  static SetCampaigns setCampaigns(Map<String, Campaign> campaigns) =>
      SetCampaigns(campaigns);
}
