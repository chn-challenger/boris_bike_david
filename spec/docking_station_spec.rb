require "docking_station"


describe DockingStation do
	it { is_expected.to respond_to (:release_bike) }


	it 'releases working bikes' do
		# subject.dock Bike.new
		# bike = subject.release_bike
		bike = double( :bike, working?:true)
		subject.dock bike
		b=subject.release_bike
		# expect(b.report_broken).to eq('broken')
		expect(b).to be_working
	end

	it { is_expected.to respond_to(:dock).with(1).argument }

	describe '#release_bike' do
		it 'raises an error when there are no bikes available' do
			expect { subject.release_bike }.to raise_error 'No bikes available'
		end

		it 'raises an error when there is only one broken bike available' do
			bike_new = double(:bike, working?:false)
			subject.dock bike_new
			expect{subject.release_bike}.to raise_error 'No bikes available'
		end
	end

	describe '#dock' do
		it 'raises an error when full' do
			station1 = DockingStation.new
			bike_new = 'bobo'
			station1.capacity.times{station1.dock(bike_new)}
			expect{ station1.dock bike_new }.to raise_error 'Docking station full'
		end
	end

	describe '#remove_broken_bikes' do
		it 'removes broken bikes' do
			bike_1 = double(:bike, working?:false)
			bike_2 = double(:bike, working?:true)
			bike_3 = double(:bike, working?:false)
			bike_4 = double(:bike, working?:true)
			subject.dock(bike_1)
			subject.dock(bike_2)
			subject.dock(bike_3)
			subject.dock(bike_4)
			expect(subject.remove_broken_bikes).to eq([bike_1,bike_3])
			expect(subject.bikes).to eq([bike_2,bike_4])
		end
	end

	it do
		station = DockingStation.new
		expect(station.capacity).to eq DockingStation::DEFAULT_CAPACITY
	end

	it do
		expect(subject).to respond_to(:capacity=).with(1).argument
	end

		it 'return a list of broken bikes' do
			bike_1 = double(:bike, working?:false)
			bike_2 = double(:bike, working?:true)
			bike_3 = double(:bike, working?:false)
			subject.dock(bike_1)
			subject.dock(bike_2)
			subject.dock(bike_3)
			expect(subject.list_broken_bikes).to eq([bike_1, bike_3])

		end


end
