//
//  CuttingAndForwardSpeed.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 16.11.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import Foundation

class CuttingAndForwardSpeed{
    
    static func getValuesFor(work: Work, workingStep: WorkingStep?, tool: Tool?, material: Material) -> (cuttingSpeed: Int?, forwardSpeed: Double?) {
        switch work {
        case .drilling:
                switch material {
                    case .steelUnder500: return (15, nil)
                    case .steelOver500: return (12, nil)
                    case .brassOrBronze: return(30, nil)
                    case .aluminium: return (40, nil)
                    case .plastic: return (50, nil)
                }
            
            case .lathing:
                switch workingStep! {
                    case .schlichten:
                        switch tool! {
                            case .HSS:
                                switch material {
                                    case .steelUnder500: return (50, 0.08)
                                    case .steelOver500: return (40, 0.08)
                                    case .brassOrBronze: return(70, 0.08)
                                    case .aluminium: return (90, 0.08)
                                    case .plastic: return (100, 0.08)
                                }
                            case .HM:
                                switch material {
                                    case .steelUnder500: return (200, 0.15)
                                    case .steelOver500: return (150, 0.15)
                                    case .brassOrBronze: return(200, 0.15)
                                    case .aluminium: return (200, 0.15)
                                    case .plastic: break
                                }
                        }
                    case .schruppen:
                        switch tool! {
                        case .HSS:
                            switch material {
                            case .steelUnder500: return (40, 0.2)
                            case .steelOver500: return (30, 0.2)
                            case .brassOrBronze: return(50, 0.2)
                            case .aluminium: return (70, 0.2)
                            case .plastic: return (70, 0.2)
                            }
                        case .HM:
                            switch material {
                            case .steelUnder500: return (120, 0.3)
                            case .steelOver500: return (100, 0.3)
                            case .brassOrBronze: return(150, 0.3)
                            case .aluminium: return (150, 0.3)
                            case .plastic: break
                            }
                        }
                    case .abstechen:
                        switch material {
                            case .steelUnder500: return (40, nil)
                            case .steelOver500: return (30, nil)
                            case .brassOrBronze: return(60, nil)
                            case .aluminium: return (50, nil)
                            case .plastic: return (70, nil)
                        }
                    
                    case .einstechen:
                        switch material {
                            case .steelUnder500: return (120, nil)
                            case .steelOver500: return (100, nil)
                            case .brassOrBronze: break
                            case .aluminium: break
                            case .plastic: break
                        }
            }
            
            case .milling:
                switch workingStep! {
                    case .schruppen:
                        switch tool! {
                            case .HSS:
                                switch material {
                                    case .steelUnder500: return (25, 0.05)
                                    case .steelOver500: return (15, 0.05)
                                    case .brassOrBronze: return(40, 0.05)
                                    case .aluminium: return (100, 0.05)
                                    case .plastic: return (70, 0.05)
                                }
                            case .HM:
                                switch material {
                                    case .steelUnder500: return (120, nil)
                                    case .steelOver500: return (60, nil)
                                    case .brassOrBronze: return(120, nil)
                                    case .aluminium: return (60, nil)
                                    case .plastic: break
                                }
                        }
                    case .schlichten:
                        switch tool! {
                            case .HSS:
                                switch material {
                                case .steelUnder500: return (32, 0.03)
                                case .steelOver500: return (20, 0.03)
                                case .brassOrBronze: return(60, 0.03)
                                case .aluminium: return (160, 0.03)
                                case .plastic: return (100, 0.03)
                            }
                            case .HM:
                                switch material {
                                case .steelUnder500: return (160, nil)
                                case .steelOver500: return (100, nil)
                                case .brassOrBronze: return(200, nil)
                                case .aluminium: return (600, nil)
                                case .plastic: break
                            }
                    }
          
                case .abstechen: break
                    
                case .einstechen: break
        
                }
        }
        return (cuttingSpeed: nil, forwardSpeed: nil)
    }
}
