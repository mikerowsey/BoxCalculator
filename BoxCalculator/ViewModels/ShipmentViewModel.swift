//
//  ShipmentViewModel.swift
//  HelloWorld
//
//  Created by Michael Rowsey on 5/29/26.
//

import Foundation
import Observation

@Observable
class ShipmentViewModel {

    var packages: [PackageItem] = [
        PackageItem()
    ]

    var totalBoxes: Double {

        packages.reduce(0) {
            $0 + (Double($1.quantity) ?? 0)
        }
    }

    var totalWeightLB: Double {

        packages.reduce(0) { total, package in

            let qty = Double(package.quantity) ?? 0
            let weight = Double(package.weight) ?? 0

            return total + (qty * weight)
        }
    }

    var totalWeightKG: Double {

        totalWeightLB * 0.453592
    }

    var totalCBM: Double {

        packages.reduce(0) { total, package in

            let qty = Double(package.quantity) ?? 0

            let l = Double(package.length) ?? 0
            let w = Double(package.width) ?? 0
            let h = Double(package.height) ?? 0

            let cubicFeet =
                (l * w * h) / 1728.0

            return total
                + (cubicFeet * 0.0283168 * qty)
        }
    }

    func lengthCM(_ package: PackageItem) -> Double {

        (Double(package.length) ?? 0) * 2.54
    }

    func widthCM(_ package: PackageItem) -> Double {

        (Double(package.width) ?? 0) * 2.54
    }

    func heightCM(_ package: PackageItem) -> Double {

        (Double(package.height) ?? 0) * 2.54
    }

    func lineWeightKG(_ package: PackageItem) -> Double {

        let qty = Double(package.quantity) ?? 0
        let weight = Double(package.weight) ?? 0

        return qty * weight * 0.453592
    }

    func lineCBM(_ package: PackageItem) -> Double {

        let qty = Double(package.quantity) ?? 0

        let l = Double(package.length) ?? 0
        let w = Double(package.width) ?? 0
        let h = Double(package.height) ?? 0

        let cubicFeet =
            (l * w * h) / 1728.0

        return cubicFeet * 0.0283168 * qty
    }

    var metricTableText: String {

        var lines: [String] = []

        let header = String(
            format: "%4s %12s %12s %12s %12s",
            ("QTY" as NSString).utf8String!,
            ("L (cm)" as NSString).utf8String!,
            ("W (cm)" as NSString).utf8String!,
            ("H (cm)" as NSString).utf8String!,
            ("KG" as NSString).utf8String!
        )

        lines.append(header)

        lines.append(
            "---------------------------------------------------------------------"
        )

        for package in packages {

            let qty =
                Double(package.quantity) ?? 0

            let line = String(
                format: "%4.0f %12.1f %12.1f %12.1f %12.2f",
                qty,
                lengthCM(package),
                widthCM(package),
                heightCM(package),
                lineWeightKG(package)
            )

            lines.append(line)
        }

        lines.append("")

        lines.append(
            "====================================================================="
        )

        lines.append(
            String(
                format: "%-20s %10.0f",
                ("TOTAL BOXES" as NSString).utf8String!,
                totalBoxes
            )
        )

        lines.append(
            String(
                format: "%-20s %10.2f",
                ("TOTAL KG" as NSString).utf8String!,
                totalWeightKG
            )
        )

        lines.append(
            String(
                format: "%-20s %10.3f",
                ("TOTAL CBM" as NSString).utf8String!,
                totalCBM
            )
        )

        return lines.joined(separator: "\n")
    }

    func addPackage() {

        packages.append(
            PackageItem()
        )
    }

    func removePackage(id: UUID) {

        packages.removeAll {
            $0.id == id
        }
    }
}
