class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list.html.erb" })
  end

  def show
    venue_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)

    if @the_venue == nil
     redirect_to ("/404")
    else
    render({ :template => "venue_templates/details.html.erb" })
     end
  end

  def create
    venue = Venue.new
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save

    redirect_to("/venues/"+ venue.id.to_s)
  end
  
  def update
    the_id = params.fetch("the_id")
    matching_venues = Venue.where({ :id => the_id })
    the_venue = matching_venues.at(0)

    new_address = params.fetch("query_address")
    new_name = params.fetch("query_name")
    new_neighborhood = params.fetch("query_neighborhood")


    the_venue.address = new_address
    the_venue.name = new_name
    the_venue.neighborhood = new_neighborhood
    the_venue.save
    
    redirect_to("/venues/"+ the_venue.id.to_s)
  end

  def destroy
    the_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues
    venue.destroy

    redirect_to("/venues")
  end

end
