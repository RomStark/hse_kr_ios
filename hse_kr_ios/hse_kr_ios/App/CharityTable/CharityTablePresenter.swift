//
//  CharityTablePresenter.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import Foundation


protocol CharityTablePresentation {
    func getCharityModels(isRecomended: Bool, completion: @escaping (Result<[Charity], Error>) -> Void)
    func addCharityButtonTapped()
}

protocol CharityTablePresentationMenagement: AnyObject {
    
}

final class CharityTablePresenter {
    private let userDefaults = UserDefaults.standard
    private var router: CharityTableRoutable
    private weak var view: CharityTableViewable?
    private var interactor: CharityTableBusinessLogic
    
    init(view: CharityTableViewable, router: CharityTableRoutable, interactor: CharityTableBusinessLogic) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

//MARK: CharityTablePresentation
extension CharityTablePresenter: CharityTablePresentation {
    func addCharityButtonTapped() {
        router.route(to: .addCharity)
    }
    func getCharityModels(isRecomended: Bool, completion: @escaping (Result<[Charity], Error>) -> Void) {
        interactor.getModels { [weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let charity):
                if isRecomended {
                    var recomendedCharity = [Charity]()
                    let recomendedDict = self?.userDefaults.dictionary(forKey: "recomendationDict")
                    
                    if recomendedDict != nil {
                        for i in charity {
                            if ((recomendedDict?["наука"]) != nil) == i.scienceResearch ||
                                ((recomendedDict?["здравоохранение"]) != nil) == i.healthcare ||
                                ((recomendedDict?["бедные"]) != nil) == i.poverty ||
                                ((recomendedDict?["Образование"]) != nil) == i.education ||
                                ((recomendedDict?["искусство"]) != nil) == i.art ||
                                ((recomendedDict?["дети"]) != nil) == i.children {
                                recomendedCharity.append(i)
                            }
                        }
                        completion(.success(recomendedCharity))
                    }
                    else { completion(.success(charity))}
                } else {
                    completion(.success(charity))
                }
            }
        }
    }
    
    
}

//MARK: CharityTablePresentationMenagement
extension CharityTablePresenter: CharityTablePresentationMenagement {
    
}
