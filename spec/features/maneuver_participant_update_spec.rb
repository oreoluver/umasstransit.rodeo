require 'rails_helper' 

describe 'updating obstacles and distance targets' do
  let!(:maneuver) { create :maneuver }
  let!(:obstacle) { create :obstacle, maneuver: maneuver }
  let!(:distance_target) { create :distance_target, maneuver: maneuver }
  let!(:maneuver_participant) do
    create :maneuver_participant,
           maneuver: maneuver
  end
  it 'updates obstacles hit with 1' do
    when_current_user_is :admin
    visit maneuver_participant_path(maneuver_participant.id)
    fill_in "obstacle_#{obstacle.id}", with: '1'
    click_on 'Save score'
    input = find_field "obstacle_#{obstacle.id}"
    expect(input.value).to eql '1'
  end

  it 'updates distance from target with 1' do
    when_current_user_is :admin
    visit maneuver_participant_path(maneuver_participant.id)
    fill_in "target_#{distance_target.id}", with: '1'
    click_on 'Save score'
    input = find_field "target_#{distance_target.id}"
    expect(input.value).to eql '1'
  end
end
