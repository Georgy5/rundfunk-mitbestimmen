require 'rails_helper'
RSpec.describe 'ChartData', type: :request do
  let(:headers) { {} }
  let(:params)  { {} }

  context 'given stations, broadcasts and selections' do
    before(:all) do
      # STATIONS
      create(:station, id: 1, name: 'Station 1')
      create(:station, id: 2, name: 'Station 2')
      create(:station, id: 3, name: 'Station 3')

      # BROADCASTS
      create(:broadcast, id: 1, station_id: 1)
      create(:broadcast, id: 2, station_id: 1)
      create(:broadcast, id: 3, station_id: 1)

      create(:broadcast, id: 4, station_id: 2)
      create(:broadcast, id: 5, station_id: 2)

      create(:broadcast, id: 6, station_id: 3)

      # SELECTIONS
      create(:selection, broadcast_id: 1, response: :positive, amount: 3)

      create(:selection, broadcast_id: 2, response: :positive, amount: 4)
      create(:selection, broadcast_id: 2, response: :positive, amount: 4)

      create(:selection, broadcast_id: 3, response: :positive, amount: 5)
      create(:selection, broadcast_id: 3, response: :positive, amount: 5)
      create(:selection, broadcast_id: 3, response: :positive, amount: 5)

      create(:selection, broadcast_id: 4, response: :positive, amount: 6)
      create(:selection, broadcast_id: 4, response: :positive, amount: 6)
      create(:selection, broadcast_id: 4, response: :positive, amount: 6)
      create(:selection, broadcast_id: 4, response: :positive, amount: 6)

      create(:selection, broadcast_id: 5, response: :positive, amount: 7)
      create(:selection, broadcast_id: 5, response: :positive, amount: 7)
      create(:selection, broadcast_id: 5, response: :positive, amount: 7)
      create(:selection, broadcast_id: 5, response: :positive, amount: 7)
      create(:selection, broadcast_id: 5, response: :positive, amount: 7)

      create(:selection, broadcast_id: 6, response: :positive, amount: 8)
      create(:selection, broadcast_id: 6, response: :positive, amount: 8)
      create(:selection, broadcast_id: 6, response: :positive, amount: 8)
      create(:selection, broadcast_id: 6, response: :positive, amount: 8)
      create(:selection, broadcast_id: 6, response: :positive, amount: 8)
      create(:selection, broadcast_id: 6, response: :positive, amount: 8)
    end

    after(:all) do
      Selection.destroy_all
      User.destroy_all
      Broadcast.destroy_all
      Station.destroy_all
      Medium.destroy_all
    end

    describe 'GET' do
      describe '/chart_data/diffs/:id' do
        let(:url) { '/chart_data/diffs/0' }
        before { get url, params: params, headers: headers }

        describe 'JSON-API compliance' do
          describe 'serialized JSON' do
            it 'id is always 0' do
              expect(parse_json(response.body, 'data/id')).to eq '0'
            end

            it 'type is "chart-data/diffs"' do
              expect(parse_json(response.body, 'data/type')).to eq 'chart-data/diffs'
            end
          end
        end

        describe 'chart data' do
          describe 'categories' do
            it 'contains station names ordered alphabetically' do
              create(:station, id: 47, name: 'Station 4')
              create(:station, id: 11, name: 'Station 5') # this will disorder the normal enumeration
              create(:broadcast, id: 7, station_id: 47)
              create(:broadcast, id: 8, station_id: 11) # and add some broadcasts, to have the new stations included
              get url, params: params, headers: headers.merge('locale' => 'en')
              expect(parse_json(response.body, 'data/attributes/categories')).to eq(['Station 1', 'Station 2', 'Station 3', 'Station 4', 'Station 5'])
            end
          end

          describe 'series' do
            describe 'names' do
              context 'if request header contains locale "en"' do
                it 'get translated to english' do
                  get url, params: params, headers: headers.merge('locale' => 'en')
                  expect(parse_json(response.body, 'data/attributes/series/0/name')).to eq 'Actual amount'
                  expect(parse_json(response.body, 'data/attributes/series/1/name')).to eq 'Expected amount'
                end
              end
            end

            describe 'data' do
              it 'contains actual amounts for every station' do
                expect(parse_json(response.body, 'data/attributes/series/0/data')).to eq ['26.0', '59.0', '48.0']
              end

              it 'contains expected amounts for every station' do
                expect(parse_json(response.body, 'data/attributes/series/1/data')).to eq ['19.0', '12.6667', '6.3333']
              end

              it 'arrays align with categories array' do
                category        = parse_json(response.body, 'data/attributes/categories/0')
                actual_amount   = parse_json(response.body, 'data/attributes/series/0/data/0')
                expected_amount = parse_json(response.body, 'data/attributes/series/1/data/0')
                expect([category, actual_amount, expected_amount]).to eq(['Station 1', '26.0', '19.0'])
              end

              context 'if no broadcast of a station ever received a vote' do
                before do
                  create(:broadcast, id: 7, station: create(:station, id: 4, name: 'Station 4'), selections: [])
                  get url, params: params, headers: headers
                end

                it 'actual amount is 0.0' do
                  expect(parse_json(response.body, 'data/attributes/series/0/data')).to eq ['26.0', '59.0', '48.0', '0.0']
                end

                it 'expected amount is 0.0' do
                  expect(parse_json(response.body, 'data/attributes/series/1/data')).to eq ['19.0', '12.6667', '6.3333', '0.0']
                end
              end
            end
          end
        end
      end
    end
  end
end
