require 'spec_helper'

describe Lita::Handlers::Mysql, lita_handler: true do
  let(:alice) do
    Lita::User.create('9001@hipchat', name: 'Alice', mention_name: 'alice')
  end

  before do
    robot.auth.add_user_to_group!(alice, :mysql_admins)
  end

  it do
    robot.auth.add_user_to_group!(user, :mysql_admins)
    is_expected.to route_command('mysql alias add foo bar baz bat').to(:alias_add)
    is_expected.to route_command('mysql alias remove foo').to(:alias_remove)
    is_expected.to route_command('mysql alias list').to(:alias_list)
  end

  describe '#alias_add' do
    it 'adds a host if the user is authorized' do
      send_command('mysql alias add foo bar baz bat', as: alice)
      expect(replies.last).to eq('MySQL alias "foo" added')
    end

    it 'warns the user and does not add a host if the name already is in use' do
      send_command('mysql alias add foo bar baz bat', as: alice)
      send_command('mysql alias add foo bar baz bat', as: alice)
      expect(replies.last).to eq('MySQL server alias "foo" already exists')
    end

    it 'does not add a host if the user is unauthorized' do
      send_command('mysql alias add foo bar baz bat')
      expect(replies.last).to eq(nil)
    end
  end

  describe '#alias_remove' do
    it 'removes a host if one exists and the user is authorized' do
      send_command('mysql alias add foo bar baz bat', as: alice)
      send_command('mysql alias remove foo', as: alice)
      expect(replies.last).to eq('MySQL server alias "foo" removed')
    end

    it 'warns the user if the alias does not exist' do
      send_command('mysql alias remove foo', as: alice)
      expect(replies.last).to eq('MySQL server alias "foo" does not exist')
    end

    it 'does not add a host if the user is unauthorized' do
      send_command('mysql alias remove foo')
      expect(replies.last).to eq(nil)
    end
  end

  describe '#alias_list' do
    it 'lists aliases if there are any' do
      send_command('mysql alias add foo bar baz bat', as: alice)
      send_command('mysql alias list')
      expect(replies.last).to eq('MySQL alias: foo, hostname: bar')
    end

    it 'warns the user if there are no aliases defined' do
      send_command('mysql alias list')
      expect(replies.last).to eq('There are no MySQL server aliases defined')
    end
  end
end
