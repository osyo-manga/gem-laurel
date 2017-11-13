require_relative '../spec_helper'

describe Laurel::Refine do
	class RefineX
		def & other
		end

		def | other
		end

		def !
		end
	end
	
	context "using Laurel::Refine" do
		using Laurel::Refine

		let(:obj) { Object.new }
		it { expect(Laurel::Proxy === obj & obj).to eq true }
		it { expect(Laurel::Proxy === obj | obj).to eq true }
		it { expect(Laurel::Proxy === !obj).to eq true }
		it { expect(Laurel::Proxy === !42).to eq true }

		let(:x) { RefineX.new }
		it { expect(Laurel::Proxy === 1 & 1).to eq false }
		it { expect(Laurel::Proxy === 1 | 1).to eq false }
		it { expect(Laurel::Proxy === x & x).to eq false }
		it { expect(Laurel::Proxy === x | x).to eq false }
		it { expect(Laurel::Proxy === !x).to eq false }
	end

	context ".usable" do
		context "using String" do
			using Laurel::Refine.usable String
			it { expect(Laurel::Proxy === ("homu" | "mami")).to eq true }
			it { expect(Laurel::Proxy === ("homu" & "mami")).to eq true }
			it { expect(Laurel::Proxy === (!"homu")).to eq true }

			it { expect{ :homu & :mami }.to raise_error(NoMethodError) }
		end

		context "using Object" do
			using Laurel::Refine.usable Object

			let(:x) { RefineX.new }
			it { expect(Laurel::Proxy === x & x).to eq false }
			it { expect(Laurel::Proxy === x | x).to eq false }
			it { expect(Laurel::Proxy === !x).to eq false }
		end

		context "using RefineX" do
			using Laurel::Refine.usable RefineX

			it { expect{ :homu & :mami }.to raise_error(NoMethodError) }
			it { expect{ "homu" & "mami" }.to raise_error(NoMethodError) }

			let(:x) { RefineX.new }
			it { expect(Laurel::Proxy === x & x).to eq true }
			it { expect(Laurel::Proxy === x | x).to eq true }
			it { expect(Laurel::Proxy === !x).to eq true }
		end
	end
end
