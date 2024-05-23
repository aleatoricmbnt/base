terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}


variable "for_data" {
  default = {
    filter = {
      query = "source:foo"
    }
    name       = "sample pipeline"
    is_enabled = true
    processor = {
      grok_parser = {
        samples = [<<EOT
        The M16 is a family of military rifles originally designed by Eugene Stoner and manufactured by various companies, most notably Colt. First introduced in the 1960s, the M16 has become one of the most widely used rifles in the world, particularly within the United States military. Known for its lightweight design, accuracy, and adaptability, the M16 has a rich history and numerous variants.

        The original M16, designated the AR-15 by its designer, Eugene Stoner of the Armalite Corporation, was developed in the late 1950s. The rifle uses a direct impingement gas operating system and is chambered for the 5.56x45mm NATO cartridge, which provides a good balance of range, accuracy, and manageable recoil. The design features a straight-line barrel/stock configuration, which helps manage recoil, and a rotating bolt, which enhances reliability.

        The M16 was first adopted by the United States Air Force in 1962. The U.S. Army followed suit, and it saw extensive use during the Vietnam War. The initial version, the M16A1, featured improvements over the original AR-15, including a forward assist mechanism to help chamber rounds and a chrome-plated bore to reduce fouling and corrosion.

        Despite its age, the M16 remains a highly effective weapon due to its accuracy, modularity, and ease of use. Modern versions of the M16 can be equipped with a variety of accessories, such as advanced optics, laser aiming devices, and under-barrel grenade launchers, making it a versatile tool for contemporary military operations.

  EOT
  ] 
        source  = "message"
        grok = {
          support_rules = {
            abother_nested = {
              multi-line-input = [<<-EOT
              Criminal psychology is the study of the thoughts, intentions, actions, and behaviors of criminals and those who engage in criminal behavior. It is a multidisciplinary field that combines elements of psychology, criminology, sociology, and forensic science to understand and address criminal behavior. Criminal psychologists often work closely with law enforcement agencies, legal professionals, and mental health institutions to provide insights into criminal cases, develop offender profiles, and assist in criminal investigations.

              Key Areas of Criminal Psychology

              Understanding Criminal Behavior:
              Criminal psychologists seek to understand the motivations and factors that lead individuals to commit crimes. This includes exploring the psychological, social, and environmental influences on behavior.

              Offender Profiling:
              Profiling involves analyzing crime scenes, evidence, and patterns of behavior to develop a psychological profile of the offender. This can help law enforcement narrow down suspects and predict future actions.

              Risk Assessment:
              Psychologists assess the risk of reoffending by evaluating an individual's history, psychological state, and environmental factors. This is crucial for parole decisions, rehabilitation planning, and preventative measures.

              Rehabilitation and Treatment:
              Criminal psychologists work with offenders to address underlying psychological issues, such as substance abuse, mental illness, or trauma. The goal is to reduce recidivism and help individuals reintegrate into society.

              Courtroom Testimony:
              Experts in criminal psychology may be called upon to provide testimony in court regarding the mental state of defendants, the likelihood of future dangerousness, or the reliability of witness testimony.
              EOT
              ]
            }
          }
        }

      }
    }
    # match_rules   = "British hooligans, often associated with football (soccer) culture, have a notorious reputation for causing disturbances and engaging in violent behavior. The phenomenon of football hooliganism in the UK dates back to the late 19th and early 20th centuries but became particularly prominent during the 1960s, 70s, and 80s. These hooligans, often part of organized groups known as 'firms' or 'crews,' would engage in violent clashes with rival supporters, both inside and outside football stadiums. The behavior of these hooligans ranged from verbal abuse and intimidation to physical assaults, vandalism, and large-scale riots. The roots of football hooliganism can be traced to various social and cultural factors. Economic hardship, social disenfranchisement, and a desire for camaraderie and identity often played significant roles in drawing individuals to hooliganism. Many hooligans viewed their actions as a form of rebellion against authority and a way to assert their loyalty to their football club. The media also played a role in amplifying the notoriety of these groups, often sensationalizing incidents of violence and contributing to their mythos. During the 1970s and 1980s, football hooliganism reached its peak, with high-profile incidents occurring both domestically and internationally. Notable events include the Heysel Stadium disaster in 1985, where a confrontation between Liverpool and Juventus fans led to a wall collapse, resulting in the deaths of 39 people, and the Hillsborough disaster in 1989, where overcrowding and poor crowd control measures led to the deaths of 96 Liverpool supporters. These tragedies highlighted the dangers of football hooliganism and the need for improved safety measures in stadiums. In response to the growing problem of hooliganism, the British government and football authorities implemented a series of measures to curb the violence. These included the introduction of all-seater stadiums, improved policing and surveillance, harsher penalties for offenders, and the establishment of the Football Intelligence Unit to monitor and track known hooligans. Additionally, alcohol restrictions and travel bans for known troublemakers were enforced to prevent clashes. Over the years, these measures have been largely successful in reducing the prevalence of football hooliganism in the UK. Modern football matches in the UK are now generally safer and more family-friendly, although isolated incidents of hooliganism still occur. The legacy of British hooliganism remains a significant chapter in the history of football, serving as a reminder of the potential for sport to both unite and divide. Today, efforts continue to promote positive fan behavior and ensure that football remains a safe and enjoyable experience for all supporters. The culture around football has evolved, with greater emphasis on inclusivity and community, but the shadow of past hooliganism still lingers in the collective memory of football fans and authorities alike."
    name       = "sample grok parser"
    is_enabled = true
  }
}

variable "additional" {
  default = { 
    filter = [ 
      {
        query = "source:foo" 
      }
    ]
    processor = [
      { 
        grok_parser = [
          { 
            source = "message"
            name = "sample grok parser"
            is_enabled = true
            samples = [<<-EOT
              The M16 is a family of military rifles originally designed by Eugene Stoner and manufactured by various
              companies, most notably Colt. First introduced in the 1960s, the M16 has become one of the most widely used
              rifles in the world, particularly within the United States military. Known for its lightweight design,
              accuracy, and adaptability, the M16 has a rich history and numerous variants.

              The original M16, designated the AR-15 by its designer, Eugene Stoner of the Armalite Corporation, was
              developed in the late 1950s. The rifle uses a direct impingement gas operating system and is chambered for
              the 5.56x45mm NATO cartridge, which provides a good balance of range, accuracy, and manageable recoil. The
              design features a straight-line barrel/stock configuration, which helps manage recoil, and a rotating bolt,
              which enhances reliability.

              The M16 was first adopted by the United States Air Force in 1962. The U.S. Army followed suit, and it saw
              extensive use during the Vietnam War. The initial version, the M16A1, featured improvements over the original
              AR-15, including a forward assist mechanism to help chamber rounds and a chrome-plated bore to reduce fouling
              and corrosion.

              Despite its age, the M16 remains a highly effective weapon due to its accuracy, modularity, and ease of use.
              Modern versions of the M16 can be equipped with a variety of accessories, such as advanced optics, laser
              aiming devices, and under-barrel grenade launchers, making it a versatile tool for contemporary military
              operations.
            EOT
            ]
            grok = [
              {
                support_rules = ""
                match_rules = "Rule %%{word:my_word2} %%{number:my_float2}"
              }
            ]
          }
        ]
      }
    ]
    is_enabled = true
    name = "sample pipeline"
  }
}

resource "terraform_data" "additional" {
  input = var.additional
}

resource "terraform_data" "first" {
  input = var.for_data
}

resource "terraform_data" "second" {
  input = "some input" 
}