class Face < ApplicationRecord
  belongs_to :photo

  scope :anger, -> {
    where("anger = ? OR anger = ? OR anger = ? OR anger = ? OR anger = ?",
      'UNLIKELY','LIKELY', 'POSSIBLE', 'LIKELY', 'VERY_LIKELY')
  }
  scope :blurred, -> {
    where("blurred = ? OR blurred = ? OR blurred = ? OR blurred = ? OR blurred = ?",
          'UNLIKELY','LIKELY', 'POSSIBLE', 'LIKELY', 'VERY_LIKELY')
  }
  scope :headwear, -> {
    where("headwear = ? OR headwear = ? OR headwear = ? OR headwear = ? OR headwear = ?",
          'UNLIKELY','LIKELY', 'POSSIBLE', 'LIKELY', 'VERY_LIKELY')
  }
  scope :joy, -> {
    where("joy = ? OR joy = ? OR joy = ? OR joy = ? OR joy = ?",
          'UNLIKELY','LIKELY', 'POSSIBLE', 'LIKELY', 'VERY_LIKELY')
  }
  scope :sorrow, -> {
    where("sorrow = ? OR sorrow = ? OR sorrow = ? OR sorrow = ? OR sorrow = ?",
          'UNLIKELY','LIKELY', 'POSSIBLE', 'LIKELY', 'VERY_LIKELY')
  }
  scope :surprise, -> {
    where("surprise = ? OR surprise = ? OR surprise = ? OR surprise = ? OR surprise = ?",
          'UNLIKELY','LIKELY', 'POSSIBLE', 'LIKELY', 'VERY_LIKELY')
  }
  scope :under_exposed, -> {
    where("under_exposed = ? OR under_exposed = ? OR under_exposed = ? OR under_exposed = ? OR under_exposed = ?",
          'UNLIKELY','LIKELY', 'POSSIBLE', 'LIKELY', 'VERY_LIKELY')
  }
end
