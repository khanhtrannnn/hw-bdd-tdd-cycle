require 'spec_helper'

describle MovieController do
    describle 'edit page for appropriate Movie' do
        it 'has to return list of hardcored ratings' do
            r = Movie.all_ratings
            r.length.should == 5
        end
    end
end    