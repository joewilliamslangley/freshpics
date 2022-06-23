class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home # make sure to edit this for pages that dont need login

  def home
    @number = rand(1..12)
    @images = {
      1 => "kcralsprmcfemr1pfr8g",
      2 => "m1kjeyeut1yotctcbmtz",
      3 => "e4tybmnuqkbbqcnaocfu",
      4 => "luvdxhrthmlac1ywvuhm",
      5 => "xy5vehozh6dvo4kn2s2k",
      6 => "krdkhm3x5cqnisrdjlqe",
      7 => "ctbc6rucqsjgtqhghcsl",
      8 => "ctbc6rucqsjgtqhghcsl",
      9 => "sztkrp1ltrq0tmgncmyl",
      10 => "jgaaljnnceinlrnhx7uh",
      11 => "q4lamjvyjrwzwktzhv1z",
      12 => "zaa6ppkdfofr72whvkdh"
    }
  end
end
