let feelColorH = {
  joy: 0,
  anger: 240,
  sorrow: 280,
  surprise: 130,
}
export default class Utility {
  
  static getFeelColor(level, type) {
    let h = feelColorH[type]
    switch(level) {
      case 'VERY_LIKELY':
        return `hsla(${h}, 100%, 50%, 1.0)`
      case 'LIKELY':
        return `hsla(${h}, 80%, 50%, 1.0)`
      case 'POSSIBLE':
        return `hsla(${h}, 60%, 50%, 1.0)`
      case 'UNLIKELY':
        return `hsla(${h}, 40%, 50%, 1.0)`
      case 'VERY_UNLIKELY':
        return `hsla(${h}, 20%, 50%, 1.0)`
      case 'UNKNOWN':
        return `hsla(360, 100%, 100%, 1)`
    }
    return 'hsla(360, 100%, 100%, 1)'
  }

  static isFeeling(level) {
    return level === 'VERY_LIKELY' || level === 'LIKELY' || level === 'POSSIBLE' || level === 'UNLIKELY'
  }
  
  static getFaceColor(face) {
    let result = 'hsla(360, 100%, 100%, 1)'
    let feels = ['joy', 'anger', 'sorrow', 'surprise']

    feels.forEach((feel) => {
        let level = face[feel]
        if (Utility.isFeeling(level)) {
          return result = Utility.getFeelColor(level, feel)
        }
    })
    return result

  }

  static getFaceText(face) {
    let result = ''
    let feels = ['joy', 'anger', 'sorrow', 'surprise']

    feels.forEach((feel) => {
      let level = face[feel]
      if (Utility.isFeeling(level)) {
        return result += `${feel}: ${level}`
      }
    })
    return result

  }

}
