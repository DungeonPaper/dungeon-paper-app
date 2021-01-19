import 'package:dungeon_paper/db/models/campaign.dart';
import 'package:dungeon_paper/src/redux/users/user_controller.dart';
part 'campaigns_actions.dart';

class CampaignsStore {
  Map<String, Campaign> campaigns;

  CampaignsStore({
    this.campaigns,
  });
}

CampaignsStore campaignsReducer(CampaignsStore state, action) {
  if (action is SetCampaigns) {
    state.campaigns = action.campaigns;
    return state;
  }

  if (action is UpsertCampaign) {
    state.campaigns.addAll({
      action.campaign.documentID: action.campaign,
    });
    return state;
  }

  if (action is RemoveCampaign) {
    state.campaigns.remove(action.campaign.documentID);
    return state;
  }

  if (action is Logout) {
    state.campaigns = {};
    return state;
  }

  return state;
}
